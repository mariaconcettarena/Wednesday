//
//  ContentView.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import SwiftUI
import SwiftData
import AVFoundation
import AVKit

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    //    @State private var selectedTab: Int = 0
    
    @State private var isBunnyMoving = false
    
    
    var body: some View {
        
        
        
        NavigationView {
            
            ZStack{
                sfondo.ignoresSafeArea()
                
                //Text("homepage")
                
                VStack(alignment: .leading, spacing: 15){
                    Image("Bunny")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 200)
                        .offset(x: isBunnyMoving ? 100 : 100, y: isBunnyMoving ? 50 : 100)
                    
                } .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            self.isBunnyMoving.toggle()
                        }
                    }
                }
                .offset(x:-100,y:-250)
                .shadow(radius: 10)
                
                //s
                
                Text("Hello!")
                    .font(.title)
                    .bold()
                
                Text("Scan barcode to get  full information about product.")
                
                //dati dalla scansione
                Spacer()
                Scanning()
                
            }
        }
    }
}



#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
