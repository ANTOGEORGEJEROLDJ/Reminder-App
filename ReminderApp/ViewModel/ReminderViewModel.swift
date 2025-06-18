//
//  ReminderViewModel.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import Foundation
import SwiftUI
import CoreData
import UserNotifications


class ReminderViewModel: ObservableObject {
    @Published var title = ""
    @Published var detail = ""
    @Published var time = Date()
    @Published var isEnabled = false
    @Published var selectedImage: UIImage?

    func save(context: NSManagedObjectContext) {
        let reminder = Reminder(context: context)
        reminder.title = title
        reminder.detail = detail
        reminder.time = time
        reminder.isEnabled = isEnabled

        if let imageData = selectedImage?.jpegData(compressionQuality: 0.8) {
            reminder.image = imageData
        }

        do {
            try context.save()
            if isEnabled {
                scheduleNotification(for: reminder)
            }
        } catch {
            print("Error saving reminder: \(error.localizedDescription)")
        }
    }

    private func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = reminder.title ?? "Reminder"
        content.body = reminder.detail ?? ""
        content.sound = .default

        guard let time = reminder.time else { return }

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: time)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled at \(dateComponents)")
            }
        }
    }
}
