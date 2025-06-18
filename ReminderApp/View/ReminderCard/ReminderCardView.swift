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
        ZStack {
            // Blurred glass effect with gradient stroke border
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            LinearGradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.3)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing),
                            lineWidth: 2
                        )
                )
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(reminder.title ?? "No Title")
                        .font(.title3.bold())
                        .foregroundColor(.black)

                    Text(reminder.detail ?? "No Details")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.8))

                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                            .foregroundColor(.white.opacity(0.6))
                        Text(reminder.time?.formatted(date: .omitted, time: .shortened) ?? "")
                            .foregroundColor(.black.opacity(0.6))
                            .font(.footnote)
                    }

                    Toggle(isOn: .constant(reminder.isEnabled)) {
                        Text("Enabled")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.footnote)
                    }
                    .disabled(true)
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                }

                Spacer()

                if let imageData = reminder.image,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        .shadow(radius: 4)
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
