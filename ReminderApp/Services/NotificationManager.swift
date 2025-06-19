//
//  NotificationManager.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import UserNotifications
import UIKit

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = reminder.title ?? "Reminder"
        content.body = reminder.detail ?? ""
        content.sound = .default

        // Use image from asset name or CoreData image blob
        if let image = UIImage(named: reminder.imageName ?? "") {
            if let attachment = saveImageAsAttachment(image: image) {
                content.attachments = [attachment]
            }
        } else if let imageData = reminder.image,
                  let image = UIImage(data: imageData),
                  let attachment = saveImageAsAttachment(image: image) {
            content.attachments = [attachment]
        }

        guard let time = reminder.time else { return }
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    private func saveImageAsAttachment(image: UIImage) -> UNNotificationAttachment? {
        let directory = FileManager.default.temporaryDirectory
        let fileName = UUID().uuidString + ".jpg"
        let fileURL = directory.appendingPathComponent(fileName)

        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }

        do {
            try imageData.write(to: fileURL)
            return try UNNotificationAttachment(identifier: fileName, url: fileURL, options: nil)
        } catch {
            print("❌ Image attachment error: \(error)")
            return nil
        }
    }

}
