//
//  WednesdayApp.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import SwiftUI
import SwiftData

@main
struct WednesdayApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State public var chronology: [Product] = []
    @State public var favourites: [Product] = []
    /*@State public var product = Product (barcode: "", name: "", company: "", description: "", image: "", category: "", country: "", isCrueltyFree: false, others: "")*/
    

    var body: some Scene {
        WindowGroup {
            
            TabView{
                ContentView(chronology: $chronology, favourite: $favourites)
                    .tabItem {
                    Label("Scan", systemImage: "barcode.viewfinder")
                }.tag(0)
                
                Chronology(products: $chronology, favourites: $favourites).tabItem {
                    Label("Chronology", systemImage: "timer")
                }.tag(1)
                
                Favourites(products: $favourites, favourites: $chronology).tabItem {
                    Label("Favourites", systemImage: "heart")
                }.tag(2)
            }

        }
        .modelContainer(sharedModelContainer)
        
        //solo per testare
        //.environment(\.locale, .init(identifier: "it"))
    }
}


