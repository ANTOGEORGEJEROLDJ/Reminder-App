//
//  Reminder.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import Foundation
import CoreData

extension Reminder {
    static func fetchAll() -> NSFetchRequest<Reminder> {
        let request: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
        return request
    }
}

