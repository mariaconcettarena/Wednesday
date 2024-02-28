//
//  ProductView.swift
//  Wednesday
//
//  Created by Maria Concetta on 20/02/24.
//

import SwiftUI

struct ProductView: View
{
    @Binding public var product: Product
    var body: some View
    {

        ZStack
        {
            VStack
            {
                Spacer()
                if let decodedImage = self.decodeBase64ToImage(base64String: product.image)
                {
                    Image(uiImage: decodedImage).resizable(capInsets: EdgeInsets()).padding().scaledToFit()
                        /*.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 150)
                    //.frame(width: 120, height: 150)
                        .padding().scaledToFit()*/
                }
                
             /*   Image("foto").resizable(capInsets: EdgeInsets()).padding().scaledToFit()
                    //.frame(width: 230,height: 330)*/
                
                VStack
                {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20)
                    {
                        Text(product.name).bold().font(.title2)
                        
                        Text("\(product.company), \(product.country)").fontWeight(.semibold)

                        Text(product.description).lineLimit(nil).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                        
                        Text(product.category)
                       
                        HStack{
                            Spacer()
                            
                            if product.category == "Hair"{
                                Image("Hair").resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }
                            else if product.category == "Body"{
                                Image("Bodycare").resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }else if product.category == "Make-up"{
                                Image("Makeup").resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }else if product.category == "Skincare"{
                                Image("Skincare").resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }else if product.category == "Perfume"{
                                Image("Perfume").resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }
                            else{
                                Image("BunnyHome").resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }
                        }
                            
                            
                        
                        
                      
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 80)
                        .foregroundColor(.white)
                        .background(Color(verde))
                        .cornerRadius(30, corners: [.topLeft, .topRight])
                }
            }
            //.edgesIgnoringSafeArea(.bottom)
            //.background(Color(verde))
            
            
        }
        
        
        /*VStack
        {
       
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
            
            
        }*/
        
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

/*#Preview {
    ProductView()
}*/
