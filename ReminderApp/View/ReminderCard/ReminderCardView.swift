//
//  ReminderCardView.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import SwiftUI

struct ReminderCardView: View {
    let reminder: Reminder

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(reminder.title ?? "No Title")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(reminder.detail ?? "No Details")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))

                    Text("⏰ \(reminder.time?.formatted(date: .omitted, time: .shortened) ?? "")")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }

                Spacer()

                if let imageData = reminder.image,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                }
            }

            Toggle("Enabled", isOn: .constant(reminder.isEnabled))
                .disabled(true)
                .toggleStyle(SwitchToggleStyle(tint: .green))
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 10)
    }
}
