//
//  ReminderList.swift
//  MyReminders
//
//  Created by Pierrick Gouerec on 06/02/2022.
//

import SwiftUI
import CoreData

struct ReminderList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.timestamp, ascending: true)],
        animation: .default)
    private var reminders: FetchedResults<Reminder>
    
    var body: some View {
        List {
            if (reminders.isEmpty) {
                Text("No reminders")
                    .foregroundColor(Color.secondary)
            } else {
                ForEach(reminders) { reminder in
                    ReminderRow(reminder: reminder)
                        .swipeActions(edge: .leading) {
                            Button(action: {
                                reminder.isDone.toggle()
                                do {
                                    try viewContext.save()
                                } catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }, label: {
                                if (reminder.isDone) {
                                    Label("Done", systemImage: "slash.circle")
                                } else {
                                    Label("Undone", systemImage: "checkmark.circle")
                                }
                            })
                                .tint((reminder.isDone) ? Color.blue.opacity(0.8) : Color.green.opacity(0.8))
                        }
                        .swipeActions {
                            Button(action: {
                                reminder.isImportant.toggle()
                                do {
                                    try viewContext.save()
                                } catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }, label: {
                                if (reminder.isImportant) {
                                    Label("Flag", systemImage: "slash.circle")
                                } else {
                                    Label("Unflag", systemImage: "exclamationmark.triangle.fill")
                                }
                            })
                            .tint((reminder.isImportant) ? Color.yellow.opacity(0.8) : Color.orange.opacity(0.8))
                        }
                        .swipeActions {
                            Button(action: {
                                viewContext.delete(reminder)
                                do {
                                    try viewContext.save()
                                } catch {
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                            .tint(Color.red.opacity(0.8))
                        }
                }
            }
        }
    }
}
