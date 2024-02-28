//
//  Onboarding.swift
//  Wednesday
//
//  Created by Michela D'Avino on 12/02/24.
//

import SwiftUI

struct Onboarding: View {
    
   /* @Binding public var chronology: [Product]
    @Binding public var favourites: [Product]
    @Binding public var product : Product
    @Binding public var found : Bool*/
    
    
    @Binding public var isPresentingOnboarding : Bool
    
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                
                sfondo.ignoresSafeArea()
                
                VStack{
                    
                    
                    Image("BunnyHome")
                        .aspectRatio(contentMode: .fit)
                    Text("BunCode")
                        .font(.largeTitle).bold()
                    
                    
                    
                    VStack(alignment: .listRowSeparatorLeading ){
                        
                        HStack{
                            Image(systemName: "barcode.viewfinder")
                            Text("Scan")
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can scan the barcode of the products.")
                            .frame(width: 350, height: 20)
                        
                        
                        HStack{
                            Image(systemName: "timer")
                            Text("Chronology")
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can see all the scanned products.")
                            .frame(width: 350, height: 20)
                        
                        
                        
                        HStack{
                            Image(systemName: "suit.heart")
                            Text("Favourites")
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can save your products as favourite.")
                            .frame(width: 350, height: 20)
                        
                        
                    }
                    .padding(.vertical)
                    
                    
                    
                    Button(action: {
                        isPresentingOnboarding = false // Imposta il valore su false per chiudere l'onboarding
                    }) {
                        Text("Let's start!")
                            .frame(width: 115, height: 50)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
    
            
            
            
        }
    }
    
}



/*#Preview {
    Onboarding(isPresentingOnboarding: $isPresentingOnboarding)
}*/


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        // Inizializza il binding booleano con valore true per mostrare l'onboarding
        let isPresentingOnboarding = Binding.constant(true)
        
        // Passa il binding alla vista Onboarding
        return Onboarding(isPresentingOnboarding: isPresentingOnboarding)
    }
}

