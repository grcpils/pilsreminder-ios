//
//  ReminderRow.swift
//  MyReminders
//
//  Created by Pierrick Gouerec on 05/02/2022.
//

import SwiftUI
import CoreData

struct ReminderRow: View {
    var reminder: Reminder
    
    var body: some View {
        HStack {
            if (reminder.isDone) {
                PillsIcon(systemName: "checkmark.circle", foregroundColor: Color.white, backgroundColor: Color.green.opacity(0.8))
            } else if (reminder.isImportant) {
                PillsIcon(systemName: "exclamationmark.triangle", foregroundColor: Color.white, backgroundColor: Color.orange.opacity(0.8))
            } else {
                PillsIcon(systemName: "sun.min.fill", foregroundColor: Color.white, backgroundColor: Color.blue.opacity(0.8))
            }
            VStack(alignment: .leading) {
                Text(reminder.title ?? "no title")
                    .font(.body)
                Text(TimestampFormatter.string(from: reminder.timestamp!))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
    
    private let TimestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
}
