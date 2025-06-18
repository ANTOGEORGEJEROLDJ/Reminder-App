////
////  ProfileScreen.swift
////  ReminderApp
////
////  Created by Paranjothi iOS MacBook Pro on 18/06/25.
////
//
//import SwiftUI
//import FirebaseAuth
//import Firebase
//import GoogleSignIn
//import GoogleSignInSwift
//import AuthenticationServices
//import CryptoKit
//
//struct ProfileScreen: View {
//    
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    private let appleLoginManager = AppleSignInManager()
//    
//    @State private var UserName = ""
//    @State private var email = ""
//    @State private var password = ""
//    @State private var navigationToSelectNewsScreen = false
//    
//    @State private var isSignedIn = false
//    @State private var errorMessage = ""
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                Image("loginImage")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 175, height: 175)
//                    .padding(.top)
//                
//                Text("Login to continue")
//                    .padding()
//                    .font(.headline)
//                    .foregroundColor(.black.opacity(0.5))
//            }
//            .padding(.top)
//            
//            VStack(spacing: 20) {
//                CustomTextField(icon: "person.fill", placeHolder: "UserName", text: $UserName)
//                CustomTextField(icon: "envelope.fill", placeHolder: "Mail", text: $email)
//                CustomTextField(icon: "lock.fill", placeHolder: "Password", text: $password)
//            }
//            .padding()
//            .background(.ultraThinMaterial)
//            .cornerRadius(20)
//            .shadow(radius: 2)
//            .padding(.horizontal)
//            .padding(.top, 10)
//            
//            
//                    
//            NavigationLink(
//                destination: SelectNewsScreen(username: UserName, email: email)
//                    .environment(\.managedObjectContext, viewContext),
//                isActive: $navigationToSelectNewsScreen
//            ) {
//                EmptyView()
//            }
//
//            Button(action: {
//                registerWithEmail()
//            }) {
//                Text("Login")
//                    .frame(width: 258, height: 22)
//                    .padding()
//                    .bold()
//                    .background(Color.orange.opacity(0.4))
//                    .foregroundColor(.black.opacity(0.7))
//                    .font(.headline)
//                    .cornerRadius(15)
//                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
//            }
//            .padding(.top, 35)
//            
//            HStack(spacing: 20) {
//                Button(action: {
//                    handleGoogleSignIn()
//                }) {
//                    Image("google")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 19, height: 19)
//                        .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
//                }
//                .frame(width: 70, height: 22)
//                .padding()
//                .background(Color.orange.opacity(0.3))
//                .cornerRadius(15)
//                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
//                
//                Button(action: {
//                    appleLoginManager.startSignInWithAppleFlow()
//                }) {
//                    Image("appleicon")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 19, height: 19)
//                }
//                .frame(width: 70, height: 22)
//                .padding()
//                .background(Color.orange.opacity(0.3))
//                .cornerRadius(15)
//                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
//            }
//            .padding(.top, 30)
//        }
//    }
//    
//    // MARK: - Email Register and Login
//    func registerWithEmail() {
//        guard !email.isEmpty, !password.isEmpty else {
//            print("Email or password empty")
//            return
//        }
//        
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                print("Registration failed: \(error.localizedDescription)")
//                return
//            }
//
//            // Set the display name
//            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//            changeRequest?.displayName = self.UserName
//            changeRequest?.commitChanges { error in
//                if let error = error {
//                    print("Failed to set display name: \(error.localizedDescription)")
//                } else {
//                    print("✅ Display name set")
//                    self.navigationToSelectNewsScreen = true
//                }
//            }
//        }
//    }
//
//    func signInWithEmail() {
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                print("Login failed: \(error.localizedDescription)")
//                return
//            }
//            
//            self.UserName = Auth.auth().currentUser?.displayName ?? ""
//            self.navigationToSelectNewsScreen = true
//        }
//    }
//    
//    // MARK: - Google Sign-In
//    func handleGoogleSignIn() {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let rootVC = windowScene.windows.first?.rootViewController else {
//            return
//        }
//
//        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in
//            if let error = error {
//                print("❌ Google Sign-In failed: \(error.localizedDescription)")
//                return
//            }
//
//            guard let result = result,
//                  let idToken = result.user.idToken?.tokenString else { return }
//
//            let credential = GoogleAuthProvider.credential(
//                withIDToken: idToken,
//                accessToken: result.user.accessToken.tokenString
//            )
//
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    print("❌ Firebase Sign-In failed: \(error.localizedDescription)")
//                } else {
//                    self.UserName = authResult?.user.displayName ?? "Google User"
//                    self.email = authResult?.user.email ?? ""
//                    self.navigationToSelectNewsScreen = true
//                    print("✅ Google Sign-In Success: \(authResult?.user.email ?? "")")
//                }
//            }
//        }
//    }
//}
//
//@available(iOS 13.0, *)
//class AppleSignInManager: NSObject {
//    func startSignInWithAppleFlow() {
//        let provider = ASAuthorizationAppleIDProvider()
//        let request = provider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self
//        controller.presentationContextProvider = self
//        controller.performRequests()
//    }
//}
//
//@available(iOS 13.0, *)
//extension AppleSignInManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return UIWindow()
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        // Add Apple sign-in logic if needed
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print("❌ Apple Sign-In Failed: \(error.localizedDescription)")
//    }
//}
//
//#Preview {
//    ProfileScreen()
//}
