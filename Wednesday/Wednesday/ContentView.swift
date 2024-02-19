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
//    @State private var selectedTab: Int = 0
    
    
    var body: some View {
        
   
            
            NavigationView {
                
                ZStack{
                    sfondo.ignoresSafeArea()
                    
                    //Text("homepage")
                    
                    VStack(alignment: .leading, spacing: 15){
                        Image("BunnyHome")
                        
                        Text("Hello!")
                            .font(.title)
                            .bold()
                        
                        Text("Scan barcode to get  full information about product.")
                        
                        //dati dalla scansione
                        Scanning()
                        
                    }
                }
            }
            

        }
    }
    


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
