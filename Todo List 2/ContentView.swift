//
//  ContentView.swift
//  Todo List 2
//
//  Created by 肇鑫 on 2022/5/7.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var managedObjectContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.startDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var item:Item?
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                if items.isEmpty {
                    Text("No Data")
                } else {
                    List(items) { item in
                        HStack {
                            Text(DateFormatter.localizedString(from: item.startDate!, dateStyle: .none, timeStyle: .short))
                            Text(item.title!)
                        }
                    }
                    .frame(minWidth: 580, minHeight: 400, idealHeight: 600)
                }
            }
            
            Button {
                add()
            } label: {
                Text("Add")
            }
            .sheet(item: $item) { item in
                AddItemView(item: item)
            }
        }
        .padding()
        .frame(width: 600, height: 600, alignment: .center)
    }
    
    private func add() {
        let item = Item(context: managedObjectContext)
        item.id = UUID()
        item.startDate = Date()
        self.item = item
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
