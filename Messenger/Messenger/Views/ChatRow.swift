//
//  ChatRow.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI

struct ChatRow: View {
    let messageType: MessageType
    let text: String
    
    var isSender: Bool {
        return messageType == .sent
    }
    
    init(text: String, messageType: MessageType) {
        self.text = text
        self.messageType = messageType
    }
    
    var body: some View {
        HStack {
            if isSender { Spacer() }
            if !isSender {
                VStack {
                    Spacer()
                    Image("photo1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45, alignment: .center)
                        .foregroundColor(.pink)
                        .clipShape(Circle())
                }
            }
            HStack {
                Text(text)
                    .padding()
                    .foregroundColor(isSender ? .white : Color(.label))
            }
            .background(isSender ? Color.blue : Color(.systemGray4))
            .cornerRadius(6)
            .padding(isSender ? .leading : .trailing,
                     isSender ? UIScreen.main.bounds.width / 3 : UIScreen.main.bounds.width / 5)
            
            if !isSender { Spacer() }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatRow(text: "Test1", messageType: .sent)
            ChatRow(text: "Test2", messageType: .received)
                
        }
    }
}
