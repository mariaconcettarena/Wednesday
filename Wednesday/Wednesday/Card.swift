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
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(verdeCard)
                    .frame(width: 120, height: 200)
                    .overlay(
                        
                        VStack{
                            
                            Rectangle()
                                .frame(height: 50)
                                .foregroundColor(verde)
                                .frame(width: 120, height: 100)
                                .offset(x:0,y:100)
                            
                            Text("Card Title")
                                .font(.subheadline).bold()
                                .foregroundColor(verdeCard)
                                .offset(x:0,y:22)
                            
                            Text("Card Subitle")
                                .font(.footnote)
                                .foregroundColor(verdeCard)
                                .offset(x:0,y:22)
                        }
                    )
                    .padding()
                
        }
        .frame(width: 120, height: 200)
        .background(Color.white)
        .cornerRadius(10)
    }
}



/*struct Card2: View {
 var body: some View {
 VStack {
 RoundedRectangle(cornerRadius: 10)
 .foregroundColor(verdeCard)
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
 }*/


#Preview{
    Card1()
}

/*#Preview{
 Card2()
 }*/



