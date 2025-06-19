////
////  ProfileScreen.swift
////  ReminderApp
////
////  Created by Paranjothi iOS MacBook Pro on 18/06/25.
////
//
//import SwiftUI
//import PhotosUI
//import FirebaseAuth
//
//struct ProfileScreen: View {
//    @Environment(\.dismiss) private var dismiss
//    @Binding var isSignedIn: Bool
//
//    @State private var UserName: String
//    @State private var email: String
//    @State private var showSignOutAlert = false
//
//    // Profile image
//    @State private var profileImage: UIImage? = nil
//    @State private var showImagePicker = false
//
//    init(UserName: String, email: String, isSignedIn: Binding<Bool>) {
//        self._UserName = State(initialValue: UserName)
//        self._email = State(initialValue: email)
//        self._isSignedIn = isSignedIn
//    }
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                LinearGradient(
//                    gradient: Gradient(colors: [.orange.opacity(0.15), .white]),
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                ).ignoresSafeArea()
//
//                ScrollView {
//                    VStack(spacing: 24) {
//
//                        // MARK: - Back Button and Title
//                        HStack {
//                            Button(action: {
//                                dismiss()
//                            }) {
//                                Image(systemName: "chevron.left")
//                                    .font(.title2)
//                                    .foregroundColor(.black)
//                                    .padding(12)
//                                    .background(Color.white.opacity(0.9))
//                                    .clipShape(Circle())
//                                    .shadow(radius: 3)
//                            }
//                            .padding(.leading)
//
//                            Spacer()
//
//                            Text("My Profile")
//                                .font(.system(size: 26, weight: .bold, design: .rounded))
//                                .foregroundColor(.black)
//
//                            Spacer()
//                            Spacer()
//                        }
//                        .padding(.top)
//
//                        // MARK: - Profile Image
//                        VStack {
//                            if let image = profileImage {
//                                Image(uiImage: image)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 130, height: 130)
//                                    .clipShape(Circle())
//                                    .overlay(Circle().stroke(Color.orange, lineWidth: 4))
//                                    .shadow(radius: 6)
//                            } else {
//                                Image(systemName: "person.circle.fill")
//                                    .resizable()
//                                    .frame(width: 130, height: 130)
//                                    .foregroundColor(.gray.opacity(0.4))
//                                    .clipShape(Circle())
//                                    .overlay(Circle().stroke(Color.orange.opacity(0.5), lineWidth: 2))
//                            }
//
//                            Button("Change Photo") {
//                                showImagePicker = true
//                            }
//                            .font(.caption)
//                            .padding(.top, 4)
//                            .foregroundColor(.orange)
//                        }
//
//                        // MARK: - User Info
//                        VStack(spacing: 12) {
//                            HStack {
//                                Text("Username:")
//                                    .fontWeight(.semibold)
//                                Spacer()
//                                Text(UserName.isEmpty ? "Not available" : UserName)
//                            }
//                            .padding(.horizontal)
//
//                            HStack {
//                                Text("Email:")
//                                    .fontWeight(.semibold)
//                                Spacer()
//                                Text(email.isEmpty ? "Not available" : email)
//                            }
//                            .padding(.horizontal)
//                        }
//                        .padding()
//                        .background(.ultraThinMaterial)
//                        .cornerRadius(16)
//                        .shadow(radius: 3)
//                        .padding(.horizontal)
//
//                        // MARK: - Sign Out Button
//                        Button(action: {
//                            showSignOutAlert = true
//                        }) {
//                            Text("Sign Out")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .bold()
//                                .background(Color.orange.opacity(0.4))
//                                .foregroundColor(.black.opacity(0.8))
//                                .cornerRadius(15)
//                                .padding(.horizontal)
//                                .shadow(color: .gray.opacity(0.4), radius: 6, x: 0, y: 3)
//                        }
//                        .alert(isPresented: $showSignOutAlert) {
//                            Alert(
//                                title: Text("Confirm Sign Out"),
//                                message: Text("Do you really want to sign out?"),
//                                primaryButton: .destructive(Text("Sign Out")) {
//                                    try? Auth.auth().signOut()
//                                    UserName = ""
//                                    email = ""
//                                    isSignedIn = false
//                                },
//                                secondaryButton: .cancel()
//                            )
//                        }
//
//                        Spacer()
//                    }
//                    .padding(.top)
//                    .sheet(isPresented: $showImagePicker) {
//                        ImagePicker(selectedImage: $profileImage)
//                    }
//                }
//            }
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//#Preview {
//    ProfileScreen(UserName: "John Doe", email: "john@example.com", isSignedIn: .constant(true))
//}
