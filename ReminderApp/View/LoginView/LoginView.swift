//
//  LoginView.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

//import SwiftUI
////import Firebase
//
//struct LoginView: View {
//    @State private var email = ""
//    @State private var password = ""
//    @State private var isLoggedIn = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            TextField("Email", text: $email)
//                .textFieldStyle(.roundedBorder)
//            SecureField("Password", text: $password)
//                .textFieldStyle(.roundedBorder)
//            Button("Login") {
//                Auth.auth().signIn(withEmail: email, password: password) { _, error in
//                    if error == nil { isLoggedIn = true }
//                }
//            }
//            .padding()
//        }
//        .padding()
//        .fullScreenCover(isPresented: $isLoggedIn) {
//            HomeView()
//        }
//    }
//}
//
//#Preview {
//    LoginView()
//}
