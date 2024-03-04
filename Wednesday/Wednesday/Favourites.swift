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
  //  @State private var categoryFilter = ""
    @Binding public var product: Product
    
    
    @State private var selectedCategories: Set<String> = []
    
    
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
                                if selectedCategories.contains(index) {
                                            selectedCategories.remove(index)
                                        } else {
                                            selectedCategories.insert(index)
                                        }
                                //categoryFilter = index
                            }, label: {
                                Text(index)
                            })
                            .font(.headline)
                            .foregroundColor(selectedCategories.contains(index) ? Color.white : Color.black)
                            .frame(width: 90, height: 30)
                            .background(selectedCategories.contains(index) ? verde : verdeCard)
                            .cornerRadius(10.0)
                            .padding(.vertical,1)
                            
                        }.onAppear {
                            if selectedCategories.isEmpty
                            {
                                selectedCategories.insert("All")
                            }

                        }
//quando seleziono una categoria diversa da all, rimuovo la selezione su all
                        .onChange(of: selectedCategories) { _ in
                            if selectedCategories.count > 1 && selectedCategories.contains("All") {
                                selectedCategories.remove("All")
                            }
                            
//quando deseleziono le categorie selezionate, si resetta alla categoria All
                            if selectedCategories.isEmpty {
                                selectedCategories.removeAll()
                                selectedCategories.insert("All")
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                ScrollView()
                {
                    HStack(spacing: 10)
                    {
                        VStack(spacing: 150)
                        {
                            ForEach($products.indices, id:\.self)
                            {
                                index in
                                
                                if(index % 2 == 0)
                                {
                                    /* visualizziamo la card se il bottone della categorie coincide col product category,se non premiamo nessun bottone o se selezioniamo All */
                                    
                                    if(selectedCategories.isEmpty || selectedCategories.contains(products[index].category) || selectedCategories.contains("All"))
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
                        
                        VStack(spacing: 150)
                        {
                            ForEach($products.indices, id:\.self)
                            {
                                index in
                                
                                if (index % 2 != 0)
                                {
                                    if(selectedCategories.contains(products[index].category) || selectedCategories.isEmpty || selectedCategories.contains("All"))
                                    {
                                        if(((products[index].name.lowercased()).contains(productFilter.lowercased())) || productFilter == "" || ((products[index].company.lowercased()).contains(productFilter.lowercased())))
                                        {
                                            Card1(favourites: $favourites, product: $products[index])
                                           
                                        }
                                    }
                                }
                                
                            }.frame(maxWidth: .infinity)
                                .offset(x: 7, y:50)
                            
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

