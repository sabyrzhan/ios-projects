//
//  ViewModifiers.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 17.05.2021.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(7)
    }
}

struct NoAutocorrectTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(7)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}
