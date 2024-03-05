//
//  Home.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

//import Foundation
import SwiftUI
import NavigationSearchBar


struct Chronology: View {
    @State private var isShowingNextPage = false
    @Binding public var products: [Product]  // CHRONOLOGY
    @Binding public var favourites: [Product]
    
    @State private var productFilter = ""
    @State var scopeSelection: Int = 0
    
    @Binding public var product: Product
    
    @Binding public var deleteChronology : Bool
    
    
    @State private var showAlert = false
    
    
    
    var body: some View
    {
        NavigationView
        {
            
            VStack(alignment: .leading)
            {
                
                //Struttura orizzontale per Searchbar, tasto "elimina cronologia" e "filtro"
                ScrollView()
                {
                    //if !deleteCards{
                    HStack(spacing: 10)
                    {   //VASTACK Dispari (sinistra)
                        VStack(spacing: 150)
                        {
                            ForEach($products.indices, id:\.self)
                            {
                                index in
                                
                                //per avere il design sfasato, utilizziamo due indici. Questo è l'indice dispari
                                if (index % 2 == 0)
                                {
                                    /* logica search bar: se il nome del prodotto in minuscolo contiene il productFilter(ciò che scriviamo) in minuscolo oppure non sciviamo nulla, visualizziamo la card */
                                    if(((products[index].name.lowercased()).contains(productFilter.lowercased())) || productFilter == "" || ((products[index].company.lowercased()).contains(productFilter.lowercased()))){
                                        
                                            Card1(favourites: $favourites, product: $products[index])
                                        
                                    }
                                }
                                
                            }.frame(maxWidth: .infinity)
                            
                                .offset(x:30,y:20)
                            //.padding(.top, 60)
                            //  .offset(x:40,y:10)
                        }
                        
                        //VASTACK Pari (destra)
                        VStack(spacing: 150)
                        {
                            ForEach($products.indices, id:\.self)
                            {
                                index in
                                
                                if (index % 2 != 0)
                                {
                                    if(((products[index].name.lowercased()).contains(productFilter.lowercased())) || productFilter == "" || ((products[index].company.lowercased()).contains(productFilter.lowercased()))){
                                        
                                            Card1(favourites: $favourites, product: $products[index])
                                        }
                                    
                                }
                                
                            }.frame(maxWidth: .infinity)
                            
                                .offset(x: 7, y:50)
                            //.padding(.top, 60)
                            //  .offset(x:10,y:40)
                        }
                        
                    }.padding(.top, 60)
                    
                    
                    
                    Spacer(minLength:300)
                    
                }
                .navigationTitle("Chronology").padding(.leading, -40)
                .navigationSearchBar(text: $productFilter, scopeSelection: $scopeSelection, options: [
                    .automaticallyShowsSearchBar: true,
                    .obscuresBackgroundDuringPresentation: false,
                    .hidesNavigationBarDuringPresentation: true,
                    .hidesSearchBarWhenScrolling: true,
                    .placeholder: "Search"],
                    actions: [
                        .onCancelButtonClicked: {
                            print("Cancel")
                        },
                        .onSearchButtonClicked: {
                            print("Search")
                        }])
                
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Menu {
                            Button(action: {
                                filterByDate(days: 7)
                            }) {
                                Label("This week", systemImage: "")
                            }
                            Button(action: {
                                filterByDate(days: 30)
                            }) {
                                Label("This month", systemImage: "")
                            }
                            Button(action: {
                                filterByDate(days: 90)
                            }) {
                                Label("Last 3 months", systemImage: "")
                            }
                            Button(action: {
                                filterByDate(days: 180)
                            }) {
                                Label("Last 6 months", systemImage: "")
                            }
                            Button(action: {
                                filterByDate(days: 365)
                            }) {
                                Label("This year", systemImage: "")
                            }
                            
                        } label: {
                            Label("", systemImage: "line.3.horizontal.decrease.circle")
                        }
                        
                        
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        Image(systemName: "xmark.bin").foregroundColor(verde).onTapGesture {
                            showAlert = true
                        }.alert(isPresented: $showAlert){
                            Alert(
                                title: Text("Alert"),
                                message: Text("All the products will be deleted"),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(Text("Delete all")) {
                                    //deleteCards = true // Nascondi le card
                                    products.removeAll()
                                    deleteChronology = true
                                    saveProductsToUserDefaults()
                                
                                }
                            )
                        }
                    }
                }
                
                
                
            }
            
        } .onAppear {
            loadProductsFromUserDefaults()
        }
     /*   .onDisappear {
            saveProductsToUserDefaults()
        } */

        
        
    }
    //}
    
    //  FUNC LOAD
    func loadProductsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "products") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Product].self, from: data) {
                // Filtra i prodotti vuoti prima di assegnarli a products
                products = decoded.filter { !$0.name.isEmpty } // Aggiungi eventuali altri controlli se necessario
            }
        }
    }
    //FUNC SAVE
    func saveProductsToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(products) {
            UserDefaults.standard.set(encoded, forKey: "products")
        }
    }
    
    
    
    
    //funzione per filtrare i prodotti in base alla data
    func filterByDate(days: Int) {
        let startDate = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        
        products = products.filter { product in
            if let productDate = extractDate(from: product.others) {
                return productDate >= startDate
            } else {
                return false
            }
        }
    }
    
    //funzione che trasforma il contenuto della stringa others in data
    func extractDate(from others: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Prova a convertire la stringa in un oggetto Date utilizzando il DateFormatter
        if let date = dateFormatter.date(from: others) {
            print("data convertita per il filtro:")
            print(date)
            
            return date
        } else {
            // Se la conversione fallisce, restituisci nil
            return nil
        }
    }
    
    
   
    
}



/*#Preview {
 Chronology()
 }*/

