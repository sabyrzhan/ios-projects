//
//  AppStateModel.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AppStateModel: ObservableObject {
    @AppStorage("currentUsername") var currentUsername = ""
    @AppStorage("currentUserEmail") var currentUserEmail = ""
    @Published var isShowingSignIn: Bool = true
    @Published var converstations: [String] = []
    @Published var messages: [Message] = []
    
    var database = Firestore.firestore()
    var auth = FirebaseAuth.Auth.auth()
    
    var otherUsername = ""
    
    init() {
        isShowingSignIn = auth.currentUser == nil
    }
}

// Search
extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        
    }
}

// Conversations
extension AppStateModel {
    func getConversations() {
        
    }
}

// Get Chat / Send Messages
extension AppStateModel {
    func observeChat() {
        
    }
    
    func sendMessage(text: String) {
        
    }
    
    func createConversationIfNeeded() {
        
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
