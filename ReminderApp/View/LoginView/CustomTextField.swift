//
//  CustomTextField.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import SwiftUI

struct CustomTextField: View {
    
    var icon: String
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .resizable()
                .frame(width: 20,height: 23)
            if placeHolder.lowercased().contains("password") {
                SecureField(placeHolder, text: $text)
            } else {
                TextField(placeHolder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
