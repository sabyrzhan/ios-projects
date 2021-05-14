//
//  SearchView.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var text: String = ""
    
    var completion: (String) -> Void
    let usernames = ["user","asdfasD", "fasdf", "wer23"]
    
    init(completion: @escaping ((String) -> Void)) {
        self.completion = completion
    }
    
    var body: some View {
        VStack {
            TextField("Username...", text: $text)
                .modifier(TextFieldModifier())
            Button("Search") {
                
            }
            List {
                ForEach(usernames, id: \.self) { name in
                    HStack {
                        Circle()
                            .frame(width: 55, height: 55, alignment: .center)
                            .foregroundColor(Color.green)
                        Text(name)
                            .font(.system(size: 24))
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                        completion(name)
                    }
                }
            }
        }.navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() { _ in }
    }
}
