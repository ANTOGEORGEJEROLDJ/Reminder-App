//
//  AddReminderView.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

//  AddReminderView.swift
//  ReminderApp

import SwiftUI

struct AddReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var context
    @StateObject private var vm = ReminderViewModel()

    let reminderTitles = [
        "Selecting Titles",
        "Drinking water",
        "Crash report",
        "Working status",
        "Lunch time",
        "Pending work",
        "Meeting reminders"
    ]

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    // Image section based on selected title
                    if let uiImage = UIImage(named: vm.title) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 180, height: 180)
                            .overlay(Text("No Image")
                                .foregroundColor(.gray))
                    }

                    // Picker
                    HStack {
                        Text("Reminder Type")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.headline)
                            .padding(.leading, 20)

                        Spacer()

                        Picker("Select Title", selection: $vm.title) {
                            ForEach(reminderTitles, id: \.self) { title in
                                Text(title).tag(title)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .frame(height: 40)
                        .foregroundColor(.black)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(10)
                        .shadow(radius: 0.3)
                        .padding(.horizontal)
                    }

                    // Description
                    VStack(alignment: .leading) {
                        Text("Description")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.headline)
                            .padding(.leading, 20)

                        TextField("Enter Description", text: $vm.detail)
                            .padding()
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                    }

                    // Time Picker
                    HStack {
                        Text("Select Time")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.headline)
                            .padding(.leading, 20)

                        Spacer()

                        DatePicker("", selection: $vm.time, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding()
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }

                    // Toggle
                    Toggle(isOn: $vm.isEnabled) {
                        Text("Enable Notification")
                            .foregroundColor(.black.opacity(0.8))
                            .bold()
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                    .padding(.horizontal)

                    // Save Button
                    Button(action: {
                        vm.save(context: context)
                        dismiss()
                    }) {
                        Text("💾 Save Reminder")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.6))
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}
