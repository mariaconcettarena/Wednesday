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
    
    let products = ["Mascara", "Rossetto"]
    
    var body: some View {
        
        
        
        
        NavigationStack{
          
            
            List{
                ForEach(searchResults, id: \.self) {
                    product in
                    NavigationLink{
                        Text(product)
                    } label: {
                        Text(product)
                    }
                }
            }
            
            Image(systemName: "line.3.horizontal.decrease.circle")
            
            
            
            .navigationTitle("Favourites")
            .searchable(text: $searchText)
        }
       
        
    }
    
    var searchResults: [String] {
            if searchText.isEmpty {
                return products
            } else {
                return products.filter
                { $0.contains(searchText)
                }
            }
        }
}


#Preview {
    Favourites()
}
