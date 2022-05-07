//
//  AddItemView.swift
//  Todo List
//
//  Created by zhaoxin on 2022/5/7.
//

import SwiftUI
import CoreData

struct AddItemView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) private var dismiss
    @State var item:Item
    
    var body: some View {
        VStack {
            Text("Add New Item")
                .font(.title2)
            
            TextField("What to do?", text: Binding($item.title) ?? .constant(""), prompt: Text("Go shopping."))
            DatePicker("When?", selection: Binding($item.startDate) ?? .constant(Date()))
            
            HStack {
                Button {
                    save()
                } label: {
                    Text("Save")
                }

                Spacer()
                
                Button {
                    cancel()
                } label: {
                    Text("Cancel")
                }
            }
        }
        .padding()
    }
    
    private func save() {
        if var title = item.title {
            title = title.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !title.isEmpty else {
                let alert = NSAlert()
                alert.messageText = NSLocalizedString("Title is empty!", comment: "")
                alert.alertStyle = .warning
                alert.addButton(withTitle: NSLocalizedString("OK", comment: ""))
                NSSound.beep()
                alert.runModal()
                
                return
            }
            
            do {
                item.title = title
                try managedObjectContext.save()
            } catch {
                let alert = NSAlert(error: error)
                NSSound.beep()
                alert.runModal()
            }
        }
        
        dismiss()
    }
    
    private func cancel() {
        managedObjectContext.rollback()
        dismiss()
    }
}
