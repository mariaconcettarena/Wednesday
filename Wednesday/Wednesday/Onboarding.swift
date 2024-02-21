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
    var body: some View {
        
        NavigationStack{
            Text("Cruelty free APP")
                .font(.title)
            
            
            VStack(alignment: .listRowSeparatorLeading ,spacing: 5){
                
                HStack{
                    Image(systemName: "barcode.viewfinder")
                    Text("Scanning")
                }.font(.headline)
                
                Text("You can scan the barcode of the products.")
                    .frame(width: 350, height: 30)
                
                
                HStack{
                    Image(systemName: "list.bullet")
                    Text("Information")
                }.font(.headline)
                
                Text("You can discover the INCI of the products.")
                    .frame(width: 350, height: 30)
                
                HStack{
                    Image(systemName: "suit.heart.fill")
                    Text("Favourites")
                }.font(.headline)
                
                Text("You can save your product as favourite.")
                    .frame(width: 350, height: 30)
               
                
            }
            .padding(.vertical, 50)
            
            
            NavigationLink(destination: ContentView(chronology: $chronology, favourite: $favourites)) {
                Text("Let's start!")
            }
            .frame(width: 115, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .fontWeight(.semibold).clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            
        }
        
        
    }
}

/*#Preview {
    Onboarding()
}*/
