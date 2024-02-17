//
//  Favourites.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI

struct Favourites: View {
    
    @State private var searchText = ""
    @State private var filterOn = false
    
    
    let products = ["Mascara", "Rossetto"]
    
    var body: some View {
        
        
        
        
        NavigationStack{
            
            
            
            
            List{
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
}


#Preview {
    Favourites()
}
