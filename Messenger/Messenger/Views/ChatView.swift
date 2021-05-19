//
//  ChatView.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI

struct ChatView: View {
    @State
    var message: String = ""
    @EnvironmentObject
    var appState: AppStateModel
    
    var otherUsername: String = ""
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(appState.messages, id: \.self) { message in
                    ChatRow(text: message.text, messageType: message.type)
                        .padding(10)
                }
            }
            
            HStack {
                TextField("Message...", text: $message)
                    .modifier(TextFieldModifier())
                SendButton(text: $message)
            }
            .padding()
        }
        .navigationBarTitle(otherUsername, displayMode: .inline)
        .onAppear {
            appState.otherUsername = otherUsername
            appState.observeChat()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUsername: "Samantha")
    }
}
