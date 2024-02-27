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
    
    @State private var isBunnyMoving = false
    @Binding public var chronology: [Product]
    @Binding public var favourite: [Product]
    @Binding public var product: Product
    @Binding public var deleteChronology: Bool
    

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
                
                
                
                VStack(alignment: .center){
                    Text("Hello!")
                        .font(.title)
                        .bold()
                        
                        
                    
                    Text("Scan barcode to get full information about product.")
                        .padding(.vertical, 5)
                        
                    //dati dalla scansione
                    
                    
                    Scanning(chronology: $chronology, favourites: $favourite, product: $product,deleteChronology: $deleteChronology)
                }
                .padding(.horizontal)
              
                
            }
        }
    }
}



/*#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}*/
