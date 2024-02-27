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
    @State private var categoryFilter = ""
    @Binding public var product: Product
    
    
    var body: some View
    {
        
        var category = ["All","Make-up", "Skincare", "Bodycare", "Hair"]
        
        NavigationView
        {
            VStack
            {
                //search bar
                TextField(" Search", text: $productFilter)
                    .padding(.vertical, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(verde, lineWidth: 1)
                    )
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(width: 370, height: 60)
                
                
                //scroll orizzontale con le categorie
                ScrollView(.horizontal, showsIndicators: false)
                {
                    HStack(spacing: 5)
                    {
                        ForEach(category, id: \.self)
                        { index in
                            Button(action: {
                                categoryFilter = index
                            }, label: {
                                Text(index)
                            })
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 90, height: 30)
                            .background(verdeCard)
                            .cornerRadius(10.0)
                            .padding(.vertical,1)
                            
                        }
                    }
                    .padding(.horizontal)
                }
                
                ScrollView()
                {
                    HStack(spacing: 10)
                    {
                        VStack(spacing: 200)
                        {
                            ForEach($products.indices, id:\.self)
                            {
                                index in
                                
                                if(index % 2 == 0)
                                {
                                    /* visualizziamo la card se il bottone della categorie coincide col product category,se non premiamo nessun bottone o se selezioniamo All */
                                    if(product.category == categoryFilter || categoryFilter == "" || categoryFilter == "All")
                                    {
                                        //filtro per search bar
                                        if(((products[index].name.lowercased()).contains(productFilter.lowercased())) || productFilter == "")
                                        {
                                            Card1(favourites: $favourites, product: $products[index])
                                        }
                                    }
                                }
                                
                            }.frame(maxWidth: .infinity)
                            
                                .offset(x:30,y:20)
                               // .offset(x:40,y:10)
                        }
                        
                        VStack(spacing: 200)
                        {
                            ForEach($products.indices, id:\.self)
                            {
                                index in
                                
                                if (index % 2 != 0)
                                {
                                    if(product.category == categoryFilter || categoryFilter == "" || categoryFilter == "All")
                                    {
                                        if(((products[index].name.lowercased()).contains(productFilter.lowercased())) || productFilter == "")
                                        {
                                            Card1(favourites: $favourites, product: $products[index])
                                           
                                        }
                                    }
                                }
                                
                            }.frame(maxWidth: .infinity)
                                .offset(x: 20, y:60)
                            
                            //.padding(.top, 60)
                                //.offset(x:10,y:40)
                        }
                        
                    }.padding(.top, 80)
                    /*// Navigazione verso la paginaScanning()
                     NavigationLink("", destination: Scanning(chronology: $products, favourites: $favourites), isActive: $isShowingNextPage)
                     .hidden()*/
                    
                    
                }.navigationTitle("Favourites").padding(.leading, -40)
                    .onAppear{
                        loadFavouritesFromUserDefaults()
                    }
            }
            
        }
        
    }
    
    func loadFavouritesFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "favourites") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Product].self, from: data) {
                favourites = decoded
            }
        }
    }
    
    

    
    
    
}



/*#Preview {
 Favourites()
 }*/

