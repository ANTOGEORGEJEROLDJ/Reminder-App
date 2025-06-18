//
//  ReminderViewModel.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import Foundation
import SwiftUI
import CoreData

class ReminderViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var detail: String = ""
    @Published var time: Date = Date()
    @Published var isEnabled: Bool = false
    var selectedImage: UIImage? = nil
    

    func save(context: NSManagedObjectContext) {
        let newReminder = Reminder(context: context)
        newReminder.title = title
        newReminder.detail = detail
        newReminder.time = time
        newReminder.isEnabled = isEnabled

        if let image = selectedImage {
            newReminder.image = image.jpegData(compressionQuality: 0.8)
        }

        do {
            try context.save()
        } catch {
            print("Failed to save reminder: \(error)")
        }
    }
}
