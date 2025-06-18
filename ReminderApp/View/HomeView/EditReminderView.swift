//
//  EditReminderView.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import SwiftUI

struct EditReminderView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var reminder: Reminder
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var time: Date = Date()
    @State private var isEnabled: Bool = true
    @State private var imageName: String = ""
    
    var onSave: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Reminder")) {
                    TextField("Title", text: $title)
                    TextField("Detail", text: $detail)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                    Toggle("Enabled", isOn: $isEnabled)
                    TextField("Image Name", text: $imageName)
                }

                Button("💾 Save") {
                    reminder.title = title
                    reminder.detail = detail
                    reminder.time = time
                    reminder.isEnabled = isEnabled
                    reminder.imageName = imageName

                    do {
                        try context.save()
                        onSave()
                    } catch {
                        print("Failed to update reminder: \(error)")
                    }
                }
            }
            .navigationTitle("Edit Reminder")
            .onAppear {
                title = reminder.title ?? ""
                detail = reminder.detail ?? ""
                time = reminder.time ?? Date()
                isEnabled = reminder.isEnabled
                imageName = reminder.imageName ?? ""
            }
        }
    }
}

