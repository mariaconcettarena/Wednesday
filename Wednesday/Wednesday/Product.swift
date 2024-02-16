//
//  Product.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI
import SwiftSoup
import WebKit

// Creazione di una struttura per rappresentare un prodotto
struct Product: Hashable, Codable {
    //var id: UUID = UUID()
    var barcode: String
    var company: String
    var description: String
    var image: String
    var category: String
    var country: String
    var standard: String
    var others: String
}


