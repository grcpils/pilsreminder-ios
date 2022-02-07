//
//  ContentView.swift
//  MyReminders
//
//  Created by Pierrick Gouerec on 05/02/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var showSheetViewAddReminder = false

    var body: some View {
        NavigationView {
            ReminderList()
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        self.showSheetViewAddReminder.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }.sheet(isPresented: $showSheetViewAddReminder) {
                        AddReminderView()
                    }
                }
            }
            Text("Select an item")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
