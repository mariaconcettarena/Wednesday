//
//  Product.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI


// Creazione di una struttura per rappresentare un prodotto
struct Product: Identifiable {
    var id: UUID = UUID()
    var name: String
    var barcode: String
    var isCrueltyFree: Bool
    //var imageURL: String // Aggiunto URL dell'immagine
}


// Creazione di un ViewModel per gestire il database locale
class ProductsViewModel: ObservableObject {
    @Published var products: [Product]
    
    init() {
        // Popola il database con esempi di prodotti
        self.products = [
            Product(name: "Prodotto 1", barcode: "123456789", isCrueltyFree: true),
            Product(name: "Prodotto 2", barcode: "987654321", isCrueltyFree: false),
            // Aggiungi altri prodotti secondo le tue esigenze
            
            Product(name: "acqua", barcode: "8053259800312", isCrueltyFree: false)
        ]
    }
    
    
    
    // Aggiungi una funzione per verificare lo stato cruelty-free di un prodotto
    /*func checkCrueltyFreeStatus(for barcode: String) -> (isCrueltyFree: Bool, productName: String?) {
        if let product = products.first(where: { $0.barcode == barcode }) {
            return (isCrueltyFree: product.isCrueltyFree, productName: product.name)
        }
        return (isCrueltyFree: false, productName: nil)
    }*/
    
    func checkCrueltyFreeStatus(for barcode: String) -> Product? {
        return products.first { $0.barcode == barcode }
    }


    
    
  }

