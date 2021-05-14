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
    var otherUsername: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical) {
                    ChatRow(text: "Hello1", messageType: .sent)
                        .padding(3)
                    ChatRow(text: "Hello2", messageType: .received)
                        .padding(3)
                    ChatRow(text: "Hello3", messageType: .received)
                        .padding(3)
                    ChatRow(text: "Hello4", messageType: .received)
                        .padding(3)
                }
                
                HStack {
                    TextField("Message...", text: $message)
                        .modifier(TextFieldModifier())
                    SendButton(text: $message)
                }
                .padding()
            }
        }
        .navigationTitle(otherUsername)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(otherUsername: "Samantha")
    }
}
