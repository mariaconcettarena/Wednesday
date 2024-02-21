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
    @Binding public var products: [Product]  // FAVOURITES
    @Binding public var chronology: [Product]
    @State private var productFilter = ""
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                VStack
                {
                    TextField("Search", text: $productFilter).padding().background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(verde, lineWidth: 1)).textFieldStyle(PlainTextFieldStyle()).frame(width: 330, height: 70)

                    //PRIMA SCROLLVIEW
                    ScrollView(.vertical, showsIndicators: false)
                    {
                        HStack()
                        {
                            VStack(spacing: 20)
                            {
                                ForEach(products.indices, id:\.self)
                                { index in
                                    Card1(product: products[index], favourites: $products)
                                }
                            }.offset(x:30,y:10)
                                
                                
                             /*   VStack(spacing: 20) {
                                    ForEach(0..<5) { index in
                                        Card1()
                                    }
                                }.offset(x:10,y:40)
                                .frame(maxWidth: .infinity) */
                            }
                        }
                    
                    
                    
                        
                        
                        // Navigazione verso la paginaScanning()
                        NavigationLink("", destination: Scanning(chronology:$chronology, favourites: $products), isActive: $isShowingNextPage)
                            .hidden()
                    }
                    .navigationTitle("Favourites")
                }
            }
        }
    }

            
            
            
            
            /*List{
                ForEach(searchResults, id: \.self) {
                    product in
                    NavigationLink(destination: Text(product)) {
                        Text(product)
                    }
                }
            }.listStyle(.plain)
            
            
            
            
            
            
                .navigationTitle("Favourites")
                .searchable(text: $searchText)
            
                .toolbar{
                    NavigationLink(destination: Category(), isActive: $filterOn){
                        Button{
                            filterOn.toggle()
                            
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
            
            
        }
        
        
        
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return []
        } else {
            return products.filter
            {
                $0.contains(searchText)
            }
        }
    }
}*/

/*
#Preview {
    Favourites()
}*/
