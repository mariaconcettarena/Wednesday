//
//  ContentView.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var selectedTab: Int = 0 // Variabile di stato per tenere traccia della scheda selezionata


    var body: some View {
        TabView (selection: $selectedTab){
            NavigationView {
                List {
                    ForEach(items) { item in
                        NavigationLink(destination: Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")) {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
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
                .navigationTitle("Inci")
            }
            .tabItem {
                Label("Inci", systemImage: "list.bullet")
            }.tag(0)
            
            Home().tabItem {
                    Label("Home", systemImage: "house")
                }.tag(1)
            
            Favourites().tabItem {
                    Label("Favourites", systemImage: "star")
                }.tag(2)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
