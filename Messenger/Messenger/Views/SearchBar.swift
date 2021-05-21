//
//  SearchBar.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 17.05.2021.
//

import Combine
import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    @State private var isEditing = false
    
    var completion: ((String) -> Void)
    
    init(completion: @escaping ((String) -> Void)) {
        self.completion = completion
    }
 
    var body: some View {
        let textBinding = Binding<String>(get: {
            self.text
        }, set: {
            self.text = $0
            completion($0)
        })
        HStack {
            TextField("Search ...", text: textBinding)
                .padding(7)
                .padding(.horizontal, 25)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                completion(self.text)
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    completion(self.text)
                    #if canImport(UIKit)
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    #endif
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar { text in
            
        }
    }
}
