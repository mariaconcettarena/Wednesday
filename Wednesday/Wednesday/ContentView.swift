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
    @State private var selectedTab: Int = 0
    
    
    var body: some View {
        
        TabView (selection: $selectedTab){
            
            
            NavigationView {
                
                //Text("homepage")
                
                
            }
            
            
            .tabItem {
                Label("Scan", systemImage: "barcode.viewfinder")
            }.tag(0)
            
            Inci().tabItem {
                Label("Inci", systemImage: "list.bullet")
            }.tag(1)
            
            Favourites().tabItem {
                Label("Favourites", systemImage: "heart")
            }.tag(2)
            
        }.navigationTitle("Scan")
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
