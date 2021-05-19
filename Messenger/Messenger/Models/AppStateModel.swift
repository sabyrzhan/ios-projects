//
//  AppStateModel.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AppStateModel: ObservableObject {
    @AppStorage("currentUsername") var currentUsername = ""
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    @Published var isShowingSignIn: Bool = true
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    
    var database = Firestore.firestore()
    var auth = FirebaseAuth.Auth.auth()
    var converstationListener: ListenerRegistration?
    var chatListener: ListenerRegistration?
    
    var otherUsername = ""
    
    init() {
        isShowingSignIn = auth.currentUser == nil
    }
}

// Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        database.collection("users").getDocuments { result, error in
            guard let users = result?.documents.compactMap({ $0.documentID }), error == nil else {
                completion([])
                return
            }
            
            let filtered = users.filter({
                $0.lowercased().hasPrefix(queryText.lowercased())
            })
            
            completion(filtered)
        }
    }
}

// Conversations
extension AppStateModel {
    func getConversations() {
        converstationListener = database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .addSnapshotListener {[weak self] result, error in
                if error != nil {
                    return
                }
                
                let usernames:[String] = result!.documents.compactMap { snapshot in
                    return snapshot.documentID
                }
                
                DispatchQueue.main.async {
                    let ss = self!.currentUsername
                    print("Current username: \(ss) and usernames: \(usernames)")
                    self?.conversations = usernames
                }
            }
    }
}

// Get Chat / Send Messages
extension AppStateModel {
    func observeChat() {
        chatListener = database
            .collection("users")
            .document(currentUsername)
            .collection("chats")
            .document(otherUsername)
            .collection("messages")
            .addSnapshotListener {[weak self] result, error in
                guard let m = result?.documents else {
                    return
                }
                
                let messages:[Message] = m.compactMap { snapshot in
                    do {
                        return try snapshot.data(as: Message.self)
                    } catch {
                        print(error)
                    }
                    return nil
                }.sorted(by: { first, second in
                    return first.created < second.created
                })
                
                DispatchQueue.main.async {
                    self?.messages = messages
                }
            }
    }
    
    func sendMessage(text: String) {
        do {
            let messageId = UUID().uuidString
            let date = Date()
            let dataSent = Message(text: text, type: .sent, created: date)
            let dataReceived = Message(text: text, type: .received, created: date)
            
            database
                .collection("users")
                .document(currentUsername)
                .collection("chats")
                .document(otherUsername)
                .setData([:])
                        
            try database
                .collection("users")
                .document(currentUsername)
                .collection("chats")
                .document(otherUsername)
                .collection("messages")
                .document(messageId)
                .setData(from: dataSent, merge: true)
            
            database
                .collection("users")
                .document(otherUsername)
                .collection("chats")
                .document(currentUsername)
                .setData([:])
            
            try database
                .collection("users")
                .document(otherUsername)
                .collection("chats")
                .document(currentUsername)
                .collection("messages")
                .document(messageId)
                .setData(from: dataReceived, merge: true)
        } catch {
            print(error)
        }
    }
}

// SignIn and SignUp
extension AppStateModel {
    func signIn(username: String, password: String) {
        database.collection("users").document(username).getDocument { [weak self] result, error in
            guard let email = result?.data()?["email"] as? String else {
                return
            }
            
            self?.auth.signIn(withEmail: email, password: password, completion: { result, error in
                guard error == nil, result != nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.currentUsername = username
                    self?.currentUserEmail = email
                    self?.isShowingSignIn = false
                }
            })
        }
    }
    
    func signUp(email: String, username: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            let data = [
                "email": email,
                "username": username
            ]
            
            self?.database
                .collection("users")
                .document(username)
                .setData(data) { error in
                    guard error == nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.currentUsername = username
                        self?.currentUserEmail = email
                        self?.isShowingSignIn = false
                    }
                }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error)
        }
    }
}
