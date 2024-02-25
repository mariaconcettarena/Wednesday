//
//  Onboarding.swift
//  Wednesday
//
//  Created by Michela D'Avino on 12/02/24.
//

import SwiftUI

struct Onboarding: View {
    
    @Binding public var chronology: [Product]
    @Binding public var favourites: [Product]
    @Binding public var product : Product
    @Binding public var found : Bool
    
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                
                sfondo.ignoresSafeArea()
                
                VStack{
                    
                    
                    Image("BunnyHome")
                        .aspectRatio(contentMode: .fit)
                    Text("BunCode")
                        .font(.largeTitle)
                    
                    
                    
                    VStack(alignment: .listRowSeparatorLeading ){
                        
                        HStack{
                            Image(systemName: "barcode.viewfinder")
                            Text("Scanning")
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can scan the barcode of the products.")
                            .frame(width: 350, height: 20)
                        
                        
                        
                        HStack{
                            Image(systemName: "suit.heart.fill")
                            Text("Favourites")
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can save your products as favourite.")
                            .frame(width: 350, height: 20)
                        
                        
                    }
                    .padding(.vertical)
                    
//                    
//                    NavigationLink(destination: ContentView(chronology: $chronology, favourite: $favourites, product: $product, found: $found)) {
//                        Text("Let's start!")
//                    }
//                    .frame(width: 115, height: 50)
//                    .background(Color.accentColor)
//                    .foregroundColor(.white)
//                    .fontWeight(.semibold).clipShape(RoundedRectangle(cornerRadius: 10))
//                    
//                    
                    
                 
                
                }
            }
            
        }
    }
}

//#Preview {
//    Onboarding()
//}
