//
//  SendButton.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI

struct SendButton: View {
    @Binding var text: String
    @EnvironmentObject var model: AppStateModel
    
    var body: some View {
        Button(action: {
            sendMessage()
        }, label: {
            Image(systemName: "paperplane")
                .font(.system(size: 33))
                .frame(width: 55, height: 55, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .clipShape(Circle())
        })
    }
    
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        model.sendMessage(text: text)
        text = ""
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        SendButton(text: .constant("SendTest"))
    }
}
