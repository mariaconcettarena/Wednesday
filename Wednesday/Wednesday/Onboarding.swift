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
                
                //sfondo.ignoresSafeArea()
                Image("back")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                
                    
                    VStack(alignment: .listRowSeparatorLeading ){
                        
                        Text("BunCode")
                            .font(.largeTitle).bold().padding()
                        
                        HStack{
                            Image(systemName: "barcode.viewfinder").offset(x:30)
                            Text("Scan").offset(x:30)
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can scan the barcode of the items.")
                            .frame(width: 350, height: 20).padding(.bottom)
                        
                        
                        HStack{
                            Image(systemName: "timer").offset(x:30)
                            Text("Chronology").offset(x:30)
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can see all the scanned items.")
                            .frame(width: 350, height: 20).padding(.bottom)
                        
                        
                        
                        HStack{
                            Image(systemName: "suit.heart").offset(x:30)
                            Text("Favourites").offset(x:30)
                        }.font(.title3).bold()
                            .foregroundColor(.accentColor)
                        
                        Text("You can save your items as favourite.")
                            .frame(width: 350, height: 20).padding(.bottom)
                        
                        
                    }.offset(y:50)
                    .padding()
                    
                    
                    
                    Button(action: {
                        isPresentingOnboarding = false // Imposta il valore su false per chiudere l'onboarding
                    }) {
                        Text("Let's start!")
                        
                            .frame(width: 290, height: 50)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }.offset(y:260)
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

