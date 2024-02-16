//
//  Home.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI



struct Inci: View {
    @State private var isShowingNextPage = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //SFONDO
               // seashell.ignoresSafeArea()
                
                VStack {
                    
                    Text("Brands").font(.title2).bold().frame(alignment: .leading)
                        .padding(.leading,-180)
                    
                    
                    //PRIMA SCROLLVIEW
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(0..<5) { index in
                                Card1()
                            }
                        }
                    }
                    
                    
                    Text("Best sellers").font(.title2).bold().frame(alignment: .leading)
                        .padding(.leading,-180)
                
                    
                    
                    // Bottone SCANNING
                    Button(action: {
                        
                        isShowingNextPage = true
                        
                    }) {
                        Image(systemName: "barcode.viewfinder")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding()
                           // .foregroundColor(resedaGreen)
                            .cornerRadius(10)
                            .font(.title)
                    }
                    .padding()
                    
                    
                    // Navigazione verso la paginaScanning()
                    NavigationLink("", destination: Scanning(), isActive: $isShowingNextPage)
                        .hidden()
                }
                .navigationTitle("Inci")
            }
        }
    }
}



#Preview {
    Inci()
}
