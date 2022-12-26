//
//  MenuView.swift
//  Capstone
//
//  Created by Braulio Viveros
//

import SwiftUI
import CoreData // Model part of MVVM

struct MenuView: View {
  
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)

  private var items: FetchedResults<Item>

  var body: some View {
    NavigationView {
      List {
        ForEach(items) { item in
          NavigationLink {
            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
          }
          label: {
            Text(item.timestamp!, formatter: itemFormatter)
          }
        }
        .onDelete(perform: deleteItems)
      }
      .navigationBarTitle(Text("ProCaffeinated")).foregroundColor(.blue)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
      Text("Select an item")
    }
    Spacer()
    // bottom navigation bar
    TabView {
      Text("Log In")
      .tabItem {
        Image(systemName: "person.fill")
        Text("Log In")
      }
      Text("Review")
      .tabItem {
        Image(systemName: "menucard.fill")
        Text("Review")
      }
      Text("Pay")
      .tabItem {
        Image(systemName: "creditcard.fill")
        Text("Pay")
      }
    }
    //.tabViewStyle(.page)
    //.colorInveIrt()
  }

  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()

      do {
          try viewContext.save()
      }
      catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)

      do {
          try viewContext.save()
      }
      catch {
          // Replace this implementation with code to handle the error appropriately.
          // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct MenuView_Previews: PreviewProvider {
  static var previews: some View {
    MenuView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
