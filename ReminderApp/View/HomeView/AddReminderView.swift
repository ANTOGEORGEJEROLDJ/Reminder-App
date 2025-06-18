//
//  AddReminderView.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var context
    @StateObject private var vm = ReminderViewModel()
    @State private var showImagePicker = false
    @State private var image: UIImage?

    let reminderTitles = [
        "Drinking water",
        "Crash report",
        "Working status",
        "Lunch time",
        "Pending work",
        "Meeting reminders"
    ]

    var body: some View {
        NavigationView {
            Form {
                // Image preview
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 150, height: 150)
                        .overlay(Text("No Image Selected").foregroundColor(.gray))
                }

                // Image picker button
                Button("Select Image") {
                    showImagePicker = true
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $image)
                        .onDisappear {
                            if let img = image {
                                vm.selectedImage = img
                            }
                        }
                }

                // Title Picker (replaces TextField)
                Picker("Select Title", selection: $vm.title) {
                    ForEach(reminderTitles, id: \.self) { title in
                        Text(title)
                    }
                }

                // Remaining fields
                TextField("Description", text: $vm.detail)
                DatePicker("Time", selection: $vm.time, displayedComponents: .hourAndMinute)
                Toggle("Enable Notification", isOn: $vm.isEnabled)
            }
            .navigationTitle("New Reminder")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        vm.save(context: context)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
