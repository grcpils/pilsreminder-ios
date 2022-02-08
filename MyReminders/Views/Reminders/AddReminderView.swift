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
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isImportant: Bool = false
    @State private var isDated: Bool = false
    @State private var date = Date()
    @State private var isTimed: Bool = false
    @FocusState private var focusState: FocusableField?
    
    @State private var confirmCancelAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .focused($focusState, equals: .title)
                        .padding([.top, .bottom], 10)
                    TextField("Notes", text: $description)
                        .padding([.top, .bottom], 10)
                }
                    
                Section {
                    Toggle(isOn: $isImportant) {
                        PillsIcon(systemName: "exclamationmark.triangle", foregroundColor: Color.white, backgroundColor: Color.orange.opacity(0.8))
                        Spacer()
                        Text("Important")
                    }
                    .padding([.top, .bottom], 6)
                }
                Section {
                    Toggle(isOn: $isDated) {
                        PillsIcon(systemName: "calendar", foregroundColor: Color.white, backgroundColor: Color.red.opacity(0.8))
                        Spacer()
                        Text("Date")
                    }
                    .padding([.top, .bottom], 6)
                    
                    if (isDated == true) {
                        withAnimation {
                            DatePicker(
                                "Start Date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                        }
                    }
                    
                    Toggle(isOn: $isTimed) {
                        PillsIcon(systemName: "clock.fill", foregroundColor: Color.white, backgroundColor: Color.blue.opacity(0.8))
                        Spacer()
                        Text("Time")
                    }
                    .padding([.top, .bottom], 6)
                    
                    if (isTimed == true) {
                        withAnimation {
                            DatePicker(
                                "Start Time",
                                selection: $date,
                                displayedComponents: [.hourAndMinute]
                            )
                        }
                    }
                }
            }
            .onSubmit {
                if ($title.wrappedValue.isEmpty) {
                    focusState = .title
                } else {
                    addItem()
                    dismiss()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    focusState = .title
                }
            }
            .navigationBarTitle(Text("New reminder"), displayMode: .inline)
            .interactiveDismissDisabled(true)
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        confirmCancelAlert = true
                    }
                }
                ToolbarItem {
                    Button("Create") {
                        if ($title.wrappedValue.isEmpty) {
                            focusState = .title
                        } else {
                            addItem()
                            dismiss()
                        }
                    }
                }
            }
        }
        .confirmationDialog(
            "Are you sure?",
            isPresented: $confirmCancelAlert,
            titleVisibility: .hidden
        ) {
            Button("Discard Changes", role: .destructive) {
                dismiss()
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
