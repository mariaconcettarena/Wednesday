//
//  ContentView.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import SwiftUI
import AVFoundation
import AVKit

struct ContentView: View {
    
    

    
    @State private var isBunnyMoving = false
    @Binding public var chronology: [Product]
    @Binding public var favourite: [Product]
    @Binding public var product: Product
    @Binding public var deleteChronology: Bool
    
    
    let images: [String] = ["an1","an2", "an3"]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
    var body: some View {

        NavigationView {
            
            ZStack{
                sfondo.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 15){
                    
                    Image("Bunny")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 250)
                        .offset(x: isBunnyMoving ? 100 : 100, y: isBunnyMoving ? 50 : 100)
               
                     /*Image(images[currentIndex])
                        .resizable().scaledToFit()
                     .frame(width: 270, height: 600) .position(x: UIScreen.main.bounds.width / 2 + 95, y: UIScreen.main.bounds.height / 2)
                                  //.aspectRatio(contentMode: .fit)
                                  .onReceive(timer) { _ in
                                      // Ogni volta che il timer si attiva, passa all'immagine successiva
                                      currentIndex = (currentIndex + 1) % images.count
                                  }*/
                    
                    
                    
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
                        .bold().offset(x:-100,y:70)
                        
                    
                    Text("Scan barcode to get full information about product.")
                        .padding(.vertical, 5).offset(y:50)
                    
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
