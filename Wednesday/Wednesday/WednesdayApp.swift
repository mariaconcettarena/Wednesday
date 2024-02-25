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
//    per salvare e recuperare lo stato di visualizzazione dell'onboarding
    @AppStorage("hasShownOnboarding") var hasShownOnboarding = false
    
    @State private var isPresentingOnboarding = false
    
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
    @State public var product = Product (barcode: "", name: "", company: "", description: "", image: "", category: "", country: "", isCrueltyFree: false, others: "")
    
    @State public var found : Bool = false
    
    var body: some Scene {
        
       
        WindowGroup {
            

                
                TabView{
                    
                    ContentView(chronology: $chronology, favourite: $favourites, product: $product, found: $found)
                        .tabItem {
                            Label("Scan", systemImage: "barcode.viewfinder")
                        }.tag(0)
                    
                    Chronology(products: $chronology, favourites: $favourites, product: $product).tabItem {
                        Label("Chronology", systemImage: "timer")
                    }.tag(1)
                    
                    Favourites(products: $favourites, favourites: $favourites, product: $product).tabItem {
                        Label("Favourites", systemImage: "heart")
                    }.tag(2)
                }
                .sheet(isPresented: $isPresentingOnboarding){
                    Onboarding(chronology: $chronology, favourites: $favourites, product: $product, found: $found)
                }.onAppear{
                    if !hasShownOnboarding{
                        isPresentingOnboarding = true
                        hasShownOnboarding = true
                    }
                }
            }
        

        .modelContainer(sharedModelContainer)
        
        //solo per testare
        .environment(\.locale, .init(identifier: "en"))
    }
}


