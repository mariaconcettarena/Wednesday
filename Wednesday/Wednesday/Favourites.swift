//
//  Favourites.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI



struct Favourites: View {
    @State private var isShowingNextPage = false
    @Binding public var products: [Product]  // CHRONOLOGY
    @Binding public var favourites: [Product]
    @State private var productFilter = ""
    
    var category = ["Make up", "Skincare", "Bodycare", "Haircare"]
    
    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .leading)
            {
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(category, id: \.self) { index in
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text(index)
                            })
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: 90, height: 30)
                                .background(verdeCard)
                                .cornerRadius(10.0)
                                .padding(.vertical)
                        }
                    }
                    .padding(.horizontal)
                }
                
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
                    
                    
                }.navigationTitle("Favourites")
                
            }
                    
                }
                
            
        }
   // }
}



/*#Preview {
    Favourites()
}*/

