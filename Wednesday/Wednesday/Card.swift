//  Card.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI

struct Card1: View {
    @State public var product: Product
    @Binding public var favourites: [Product]
    var body: some View {
        VStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(verdeCard)
                    .frame(width: 150, height: 230)
                    .overlay(
                        
                        VStack{
                            
                            Rectangle()
                                .frame(height: 25)
                                .foregroundColor(verde)
                                .frame(width: 150, height: 5)
                                .offset(x:0,y:165)
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 50)
                                .foregroundColor(verde)
                                .frame(width: 150, height: 125)
                                .offset(x:0,y:105)
                            
                            Text(product.name)
                                .font(.subheadline).bold()
                                .foregroundColor(verdeCard)
                                .offset(x:0,y:18)
                            
                            Text(product.company)
                                .font(.footnote)
                                .foregroundColor(verdeCard)
                                .offset(x:0,y:16)
                            
                            Button (action:{
                                if(!(favourites.contains(where: {$0.barcode == self.product.barcode}))){

                                    favourites.append(self.product)  }
                                else
                                {
                                    favourites.remove(at: (favourites.firstIndex(where: {$0.barcode == self.product.barcode})!))
                                }
                            }, label: {
                                Image(systemName:
                                        (favourites.contains(where: {$0.barcode == self.product.barcode})) ? "heart.circle.fill" : "heart.circle")
                                .bold ()
                                .font(.system(size: 25))
                                
                            })
                        }
                    )
                    .padding()
                
        }
        .frame(width: 150, height: 230)
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


/*#Preview{
    Card1()
}*/

/*#Preview{
 Card2()
 }*/



