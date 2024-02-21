//
//  Home.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI



struct Chronology: View {
    @State private var isShowingNextPage = false
    @Binding public var products: [Product]  // CHRONOLOGY
    @Binding public var favourites: [Product]
    @State private var productFilter = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    
                    
                    TextField("Search", text: $productFilter)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(verde, lineWidth: 1) 
                        )
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(width: 330, height: 70)

                       
                        
                    
                    
                    //PRIMA SCROLLVIEW
                    ScrollView(.vertical, showsIndicators: false) {
                        HStack(){
                            VStack(spacing: 20) {
                                ForEach(0..<products.count)
                                {
                                    index in
                                    Card1(product: products[index], favourites: $favourites)
                                }
                            }.offset(x:30,y:10)
                            
                            
                           /* VStack(spacing: 20) {
                                ForEach(0..<5) { index in
                                    Card1()
                                }
                            }.offset(x:10,y:40)
                            .frame(maxWidth: .infinity)*/
                        }
                    }
                
                
                
                    
                    
                    // Navigazione verso la paginaScanning()
                    NavigationLink("", destination: Scanning(chronology: $products, favourites: $favourites), isActive: $isShowingNextPage)
                        .hidden()
                }
                .navigationTitle("Chronology")
            }
        }
    }
}



/*#Preview {
    Chronology()
}*/
