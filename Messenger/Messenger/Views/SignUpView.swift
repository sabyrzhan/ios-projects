//
//  SignUpView.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI

struct SignUpView: View {
    @State
    var username: String = ""
    @State
    var email: String = ""
    @State
    var password: String = ""
    @EnvironmentObject
    var state: AppStateModel
    

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120, alignment: .center)
            VStack {
                TextField("Email", text: $email)
                    .modifier(NoAutocorrectTextFieldModifier())
                TextField("Username", text: $username)
                    .modifier(NoAutocorrectTextFieldModifier())
                SecureField("Password", text: $password)
                    .modifier(NoAutocorrectTextFieldModifier())
                Button (action: {
                    signUp()
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(Color(.white))
                        .frame(width: 220, height: 50)
                        .background(Color(.systemGreen))
                        .cornerRadius(6)
                })
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Create Account", displayMode: .inline)
        
    }
    
    func signUp() {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              password.count >= 6 else {
            return
        }
        
        state.signUp(email: email, username: username, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
