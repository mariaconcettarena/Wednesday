//  Card.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import SwiftUI

struct Card1: View //VIENE MOSTRATA SE CLICCO SULLA CARD DA CRONOLOGIA/PREFERITI
{
    @Binding public var favourites: [Product]
    @Binding public var product: Product
    
    var body: some View
    {
        ZStack
        {
            //sfondo della card, verdechiaro
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(verdeCard)
                .shadow(radius: 5).frame(height:230)
            
            NavigationLink(destination: ProductView(product: $product))
            {
                VStack
                {
                    HStack
                    {
                        Spacer()
                        
                        Button (action:{
                            if(!(favourites.contains(where: {$0.barcode == self.product.barcode}))){
                                
                                favourites.append(self.product)
                            }
                            else
                            {
                                favourites.remove(at: (favourites.firstIndex(where: {$0.barcode == self.product.barcode})!))
                            }
                            saveFavouritesToUserDefaults()
                        }, label: {
                            Image(systemName:
                                    (favourites.contains(where: {$0.barcode == self.product.barcode})) ? "heart.fill" : "heart")
                            .bold ()
                            .font(.system(size: 20))
                            .scaledToFit()
                            
                        }).offset(x:-10, y: 10) // Sposto il bottone un pò piu dentro la card
                    }
                    
                    if let decodedImage = self.decodeBase64ToImage(base64String: product.image)
                    {
                        Image(uiImage: decodedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 130)
                        //.frame(width: 120, height: 150)
                            .padding()
                    }
                    
                    ZStack{
                        //rettangolino verde che sta sopra il roundedrectangle
                    Rectangle().foregroundColor(verde).frame(maxWidth: .infinity)
                        .frame(height: 25).offset(x:0,y:-15)
                    
                        //roundedrectangle
                    RoundedRectangle(cornerRadius: 20)
                        .fill(verde)
                        .frame(maxWidth: .infinity) // Imposta la larghezza massima del rettangolo verde
                        .frame(height: 40)
                        .overlay(
                            VStack(alignment: .center)
                            {   //nome prodotto
                                Text(product.name).scaleEffect(0.8)
                                    .foregroundColor(.white)
                                    .font(.headline).multilineTextAlignment(.center)
                             
                                //company
                                Text(product.company).scaleEffect(0.8)
                                    .foregroundColor(.white)
                                    .font(.subheadline).multilineTextAlignment(.center)
                                    .offset(y:-5)
                                
                                
                                //Aggiungo la data di scansione nel campo others
                                //Text(product.others) .foregroundColor(.white)
                            }
                        )
                }
                }
            }
        }
        .padding().frame(width: 90, height: 110)
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
    
    
    // Aggiungi le funzioni di salvataggio e caricamento dei preferiti dalle UserDefaults
    func saveFavouritesToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favourites) {
            UserDefaults.standard.set(encoded, forKey: "favourites")
        }
    }
}



