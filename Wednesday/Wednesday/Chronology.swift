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
    @Binding public var product: Product
    //@State public var product: Product
    
    
    @State private var deleteCards = false
    @State private var showAlert = false
    
    
    
    var body: some View
    {
        NavigationView
        {
            
            VStack(alignment: .leading)
            {
                
                //Struttura orizzontale per Searchbar, tasto "elimina cronologia" e "filtro"
                
                HStack {
                    Spacer()
                    
                    //per ora ancora non fuziona, è solo grafico
                    TextField("Search", text: $productFilter)
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
                     
                     .frame(width: 300, height: 70)
                    
                    
                    
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
                    
                    
                    
                    //Bottone per tasto elimina TO DO
                    Image(systemName: "xmark.bin").foregroundColor(verde).onTapGesture {
                        showAlert = true
                    }.alert(isPresented: $showAlert){
                        Alert(
                            title: Text("Alert"),
                            message: Text("All the products will be deleted"),
                            primaryButton: .cancel(),
                            secondaryButton: .destructive(Text("Delete all")) {
                                deleteCards = true // Nascondi le card
                                products.removeAll() // Rimuovi gli elementi dall'array
                            }
                        )
                    }
                    
                    
                }.padding(.horizontal)
                    .padding(.bottom)
                
                
                
                
                
                
                
                
                ScrollView()
                {
                    if !deleteCards{
                        HStack
                        {
                            VStack(spacing: 200)
                            {
                                ForEach($products.indices, id:\.self)
                                {
                                    index in
                                    
                                    
                                    if (index % 2 != 0)
                                    {
                                        if(((product.name.lowercased()).contains(productFilter.lowercased())) || productFilter == ""){
                                            Card1(favourites: $favourites, product: $products[index])
                                        }
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
                                        if(((product.name.lowercased()).contains(productFilter.lowercased())) || productFilter == ""){
                                        
                                            Card1(favourites: $favourites, product: $products[index])
                                        }
                                    }
                                    
                                }.frame(maxWidth: .infinity)
                                
                                
                                //.padding(.top, 60)
                                    .offset(x:10,y:40)
                            }
                            
                        }.padding(.top, 80)
                        /*// Navigazione verso la paginaScanning()
                         NavigationLink("", destination: Scanning(chronology: $products, favourites: $favourites), isActive: $isShowingNextPage)
                         .hidden()*/
                    }
                    
                }.navigationTitle("Chronology").padding(.leading, -40)
                
            }
            
        }
        
        
    }
    //}
    
    
    
    
    
    
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
    
    //funzione che filtra in base al nome del prodotto TO DO
    

}



/*#Preview {
 Chronology()
 }*/

