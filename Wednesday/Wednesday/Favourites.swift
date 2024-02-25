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
    @Binding public var product: Product
    
    
    var body: some View
    {
        
        var category = ["Make up", "Skincare", "Bodycare", "Haircare"]
        
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
                   
                    
                        HStack
                        {
                            VStack(spacing: 200)
                            {
                                ForEach($products.indices, id:\.self)
                                {
                                    index in
                                    
                                    
                                    if (index % 2 != 0)
                                    {
                                        Card1(favourites: $favourites, product: $products[index])
                                    }
                                    
                                }.frame(maxWidth: .infinity)
                                
                                
                                //.padding(.top, 60)
                                    .offset(x:30,y:10)
                            }
                            
                            VStack(spacing: 200)
                            {
                                ForEach($products.indices, id:\.self)
                                {
                                    index in
                                    
                                    if (index % 2 == 0)
                                    {
                                        Card1(favourites: $favourites, product: $products[index])
                                    }
                                    
                                }.frame(maxWidth: .infinity)
                                
                                
                                //.padding(.top, 60)
                                    .offset(x:10,y:40)
                            }
                            
                        }.padding(.top, 80)
                        /*// Navigazione verso la paginaScanning()
                         NavigationLink("", destination: Scanning(chronology: $products, favourites: $favourites), isActive: $isShowingNextPage)
                         .hidden()*/
                        
                        
                    }.navigationTitle("Favourites").padding(.leading, -40)
                
            }
                    
                }
                
            
        }
    //}
}



/*#Preview {
    Favourites()
}*/

