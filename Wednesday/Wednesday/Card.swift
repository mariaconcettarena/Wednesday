//  Card.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import SwiftUI
import Foundation






struct Card1: View //VIENE MOSTRATA SE CLICCO SULLA CARD DA CRONOLOGIA/PREFERITI
{
    //@State public var product: Product
    @Binding public var favourites: [Product]
    @Binding public var product: Product
   
    
    var body: some View
    {
        
        //NavigationLink(destination: ProductView(product: $product))
        // {
        ZStack
        {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(verdeCard)
                .shadow(radius: 5)
            NavigationLink(destination: ProductView(product: $product))
            {
                VStack
                {
                    HStack
                    {
                        Spacer()
                        
                        Button (action:{
                            if(!(favourites.contains(where: {$0.barcode == self.product.barcode}))){
                                
                                favourites.append(self.product)  }
                            else
                            {
                                favourites.remove(at: (favourites.firstIndex(where: {$0.barcode == self.product.barcode})!))
                            }
                        }, label: {
                            Image(systemName:
                                    (favourites.contains(where: {$0.barcode == self.product.barcode})) ? "heart.fill" : "heart")
                            .bold ()
                            .font(.system(size: 20))
                            
                        })
                    }
                    
                    
                    if let decodedImage = self.decodeBase64ToImage(base64String: product.image)
                    {
                        Image(uiImage: decodedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 150)
                        //.frame(width: 120, height: 150)
                            .padding()
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(verde)
                        .frame(maxWidth: .infinity) // Imposta la larghezza massima del rettangolo verde
                        .frame(height: 70)
                    //.frame(height: 50)
                        .overlay(
                            VStack(alignment: .center)
                            {
                                Text(product.name).scaleEffect(0.8)
                                    .foregroundColor(.white)
                                    .font(.headline).multilineTextAlignment(.center)
                                //.lineLimit(nil)
                                Text(product.company).scaleEffect(0.8)
                                    .foregroundColor(.white)
                                    .font(.subheadline).multilineTextAlignment(.center)
                                
                                
                                //Aggiungo la data di scansione nel campo others
                                //Text(product.others) .foregroundColor(.white)
                            }
                            //.padding(.leading)
                        )
                }
            }
        }
        .padding().frame(width: 90, height: 130)
        //.frame(width: 150, height: 230)
        
        //}
    }
    
    func decodeBase64ToImage(base64String: String) -> UIImage?
    {
        guard let imageData = Data(base64Encoded: base64String)
        else
        {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    
}


