//
//  Category.swift
//  Wednesday
//
//  Created by Michela D'Avino on 17/02/24.
//

import SwiftUI

struct Category: View {
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false) {

            
            ForEach(0..<10){
                index in
                
                HStack{
                    Image(systemName: "heart")
                    
                    VStack (alignment: .leading){
                        Text("Title").font(.title)
                        Text("Subtitle")
                    }
                }
                .frame(width: 390, height: 110)
                .background(verdeCard)
                .cornerRadius(20)
            }
            
        }
        
       
    }
}

#Preview {
    Category()
}
