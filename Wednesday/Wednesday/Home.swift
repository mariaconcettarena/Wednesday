//
//  Home.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI

//variabili per i colori
let resedaGreen = Color(red: 113/255, green: 119/255, blue: 68/255)

struct Home: View {
    @State private var isShowingNextPage = false

    var body: some View {
       
            NavigationView {
              
                VStack {
                    Text("Home")
                    
                    // Bottone personalizzato
                    Button(action: {
                        // Azione quando il bottone viene premuto
                        isShowingNextPage = true
                    }) {
                        Image(systemName: "barcode.viewfinder")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                            .foregroundColor(resedaGreen)
                            .cornerRadius(10)
                            .font(.title)
                    }
                    .padding()
                    
                    
                    // Navigazione verso la pagina Scanning()
                    NavigationLink("", destination: Scanning(), isActive: $isShowingNextPage)
                        .hidden()
                }
                .navigationTitle("Home")
            
        }}
}



#Preview {
    Home()
}
