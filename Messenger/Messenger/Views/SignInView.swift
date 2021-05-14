//
//  SignInView.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import SwiftUI

struct SignInView: View {
    @State
    var username: String = ""
    @State
    var password: String = ""
    @EnvironmentObject
    var state: AppStateModel
    

    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120, alignment: .center)
                Text("Messenger")
                    .bold()
                    .font(.system(size: 34))
                VStack {
                    TextField("Username", text: $username)
                        .modifier(NoAutocorrectTextFieldModifier())
                    SecureField("Password", text: $password)
                        .modifier(NoAutocorrectTextFieldModifier())
                    Button (action: {
                        signIn()
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(Color(.white))
                            .frame(width: 220, height: 50)
                            .background(Color(.blue))
                            .cornerRadius(6)
                    })
                }
                Spacer()
                HStack {
                    Text("New to Messenger?")
                    NavigationLink("Create Account", destination: SignUpView())
                }
                Spacer()
            }
        }
        
    }
    
    func signIn() {
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              password.count >= 6 else {
            return
        }
        
        state.signIn(username: username, password: password)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
