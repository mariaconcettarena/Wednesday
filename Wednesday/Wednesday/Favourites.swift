//
//  Favourites.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI
import NavigationSearchBar

struct Favourites: View {
    @State private var isShowingNextPage = false
    @Binding public var products: [Product]  // CHRONOLOGY
    @Binding public var favourites: [Product]
    @State private var productFilter = ""
    @State private var scopeSelection : Int = 0
    @State private var categoryFilter = ""
    @Binding public var product: Product
    
    
    var body: some View
    {
        
        var category = ["All","Make-up", "Skincare", "Bodycare", "Hair", "Perfume"]
        
        NavigationView
        {
            VStack
            {
          
                
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
                            .foregroundColor(categoryFilter == index ? Color.white : Color.black)
                            .frame(width: 90, height: 30)
                            .background(categoryFilter == index ? verde : verdeCard)
                            .cornerRadius(10.0)
                            .padding(.vertical,1)
                            
                        }.onAppear {
                            if categoryFilter == nil || categoryFilter == ""
                            {
                                categoryFilter = "All"
                            }
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
                                    if(products[index].category == categoryFilter || categoryFilter == "" || categoryFilter == "All")
                                    {
                                        //filtro per search bar
                                        if(((products[index].name.lowercased()).contains(productFilter.lowercased())) || productFilter == "" || ((products[index].company.lowercased()).contains(productFilter.lowercased())))
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
                                    if(products[index].category == categoryFilter || categoryFilter == "" || categoryFilter == "All")
                                    {
                                        if(((products[index].name.lowercased()).contains(productFilter.lowercased())) || productFilter == "" || ((products[index].company.lowercased()).contains(productFilter.lowercased())))
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
                 
                    
                    Spacer(minLength: 300)
                }.navigationTitle("Favourites").padding(.leading, -40)
                    
                    .navigationSearchBar(text: $productFilter, scopeSelection: $scopeSelection, options: [
                        .automaticallyShowsSearchBar: true,
                        .obscuresBackgroundDuringPresentation: true,
                        .hidesNavigationBarDuringPresentation: true,
                        .hidesSearchBarWhenScrolling: false,
                        .placeholder: "Search"],
                        actions: [
                            .onCancelButtonClicked: {
                                print("Cancel")
                            },
                            .onSearchButtonClicked: {
                                print("Search")
                            }])
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

