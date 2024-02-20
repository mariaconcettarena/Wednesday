//
//  ProductView.swift
//  Wednesday
//
//  Created by Maria Concetta on 20/02/24.
//

import SwiftUI

struct ProductView: View {

    var body: some View {
        
        
        VStack{
       
            //sfondo verde
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(verde)
                .frame(width: 400, height: 320)
                .offset(x:0,y:-30)
            
            //card bianca del prodotto
            RoundedRectangle(cornerRadius: 30).foregroundColor(.white).shadow(radius: 10)
                .frame(width: 250, height: 250)
                .offset(x:0,y:-190)
            
            //immagine del prodotto in cui dovrà andare product.image
            Image("Bunny").resizable().scaledToFit().offset(x:0,y:-420)
                .frame(width: 160, height: 180)
            
            
            //testo in cui deve andare product.name, product.company, product.description
            Text("NOME PRODOTTO").bold().offset(x:-100,y:-340).font(.title3)
            
            Text("Altra scritta").offset(x:-150,y:-340).font(.footnote)
            
            Text("Descrizione.....").offset(x:-135,y:-300).font(.subheadline)
            
            
        }
        
    }
}

#Preview {
    ProductView()
}
