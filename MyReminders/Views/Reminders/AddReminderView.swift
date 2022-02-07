//
//  AddReminderView.swift
//  MyReminders
//
//  Created by Pierrick Gouerec on 05/02/2022.
//

import SwiftUI

struct AddReminderView: View {
    enum FocusableField: Hashable {
        case title
    }

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var isImportant: Bool = false
    @FocusState private var focusState: FocusableField?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                    .focused($focusState, equals: .title)
                    
                Toggle(isOn: $isImportant) {
                    PillsIcon(systemName: "exclamationmark.triangle", foregroundColor: Color.white, backgroundColor: Color.orange.opacity(0.8))
                    Spacer()
                    Text("Important")
                }
                Section {
                    Button("Create") {
                        if ($title.wrappedValue.isEmpty) {
                            focusState = .title
                        } else {
                            addItem()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .onSubmit {
                if ($title.wrappedValue.isEmpty) {
                    focusState = .title
                } else {
                    addItem()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle(Text("New reminder"), displayMode: .inline)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    focusState = .title
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Reminder(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = $title.wrappedValue
            newItem.isImportant = $isImportant.wrappedValue

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
