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
                  
                }
                
        
                
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
           
            
            
        }
        

        
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
