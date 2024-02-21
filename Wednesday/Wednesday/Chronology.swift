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
    
    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .leading)
            {
                /* TextField("Search", text: $productFilter)
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
                                        .frame(width: 330, height: 70)*/
                
                ScrollView()
                {
                    ForEach(products.indices, id:\.self)
                    {
                        index in
                        Card1(product: products[index], favourites: $favourites)
                    }.frame(maxWidth: .infinity)
                    
                    
                        .padding(.top, 60)
                    //.offset(x:10,y:10)
                    
                    /*// Navigazione verso la paginaScanning()
                    NavigationLink("", destination: Scanning(chronology: $products, favourites: $favourites), isActive: $isShowingNextPage)
                        .hidden()*/
                    
                    
                }.navigationTitle("Chronology")
                
            }
                    
                }
                
            
        }
   // }
}



/*#Preview {
    Chronology()
}*/

