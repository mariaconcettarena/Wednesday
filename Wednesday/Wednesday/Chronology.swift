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
                
                //Struttura orizzontale per tasto "elimina cronologia" e "filtro"
                
                
                HStack {
                    Spacer()
                    
                    Menu {
                        Button(action: {
                            
                        }) {
                            Label("This week", systemImage: "")
                        }
                        Button(action: {
                            
                        }) {
                            Label("This month", systemImage: "")
                        }
                        Button(action: {
                            
                        }) {
                            Label("Last 3 months", systemImage: "")
                        }
                        Button(action: {
                            
                        }) {
                            Label("Last 6 months", systemImage: "")
                        }
                        Button(action: {
                            
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
                    }
                    
                }.navigationTitle("Chronology").padding(.leading, -40)
                
            }
            
        }
        
        
    }
    //}
}



/*#Preview {
 Chronology()
 }*/

