//
//  ContentView.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject
    var appState: AppStateModel
    @State
    var otherUsername = ""
    @State
    var showChat = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                SearchBar { text in
                    guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                        appState.getConversations()
                        return
                    }
                    
                    print(text)

                    let filteredList = appState.conversations.filter {name in
                        return name.lowercased().hasPrefix(text.lowercased())
                    }

                    print(filteredList)

                    appState.conversations = filteredList
                }
                ForEach(appState.conversations, id: \.self) { name in
                    NavigationLink(
                        destination: ChatView(otherUsername: name),
                        label: {
                            HStack {
                                Image("photo1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 65, height: 65, alignment: .center)
                                    .foregroundColor(.pink)
                                    .clipShape(Circle())
                                Text(name)
                                    .bold()
                                    .foregroundColor(Color(.label))
                                    .font(.system(size: 32))
                                Spacer()
                            }
                            .padding()
                        }
                    )
                }
                if !otherUsername.isEmpty {
                    NavigationLink("", destination: ChatView(message: "", otherUsername: otherUsername), isActive: $showChat)
                }
            }
            .navigationTitle("Conversations")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("Sign out") {
                        self.signOut()
                    }
                })
                ToolbarItem(
                    placement: .navigationBarTrailing, content: {
                        NavigationLink(
                            destination: SearchView { username in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                    self.otherUsername = username
                                    self.showChat = true
                                })
                            },
                            label: {
                                Image(systemName: "magnifyingglass")
                            })
                })
            }
        }
        .fullScreenCover(isPresented: $appState.isShowingSignIn, content: {
            SignInView()
        })
        .onAppear {
            guard appState.auth.currentUser != nil else {
                return
            }
            
            appState.getConversations()
        }
    }
    
    func signOut() {
        appState.signOut()
        appState.isShowingSignIn = true
    }
}

struct ConverstionListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
