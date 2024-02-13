//
//  Card.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI


struct Card1: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(resedaGreen.opacity(0.7))
                .frame(width: 150, height: 100)
                .overlay(
                    Text("Card Title")
                        .font(.headline)
                        .foregroundColor(seashell)
                )
                .padding()
        }
        .frame(width: 150, height: 100)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct Card2: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(resedaGreen)
                .frame(width: 150, height: 200)
                .overlay(
                    Text("Card Title")
                        .font(.headline)
                        .foregroundColor(seashell)
                )
                .padding()
        }
        .frame(width: 150, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


#Preview{
    Card1()
}

#Preview{
    Card2()
}



