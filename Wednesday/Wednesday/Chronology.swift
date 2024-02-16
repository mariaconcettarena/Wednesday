//
//  Home.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI



struct Chronology: View {
    @State private var isShowingNextPage = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                   

                    
                    //PRIMA SCROLLVIEW
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(0..<5) { index in
                                Card1()
                            }
                        }
                    }
                
                
                
                    
                    
                    // Navigazione verso la paginaScanning()
                    NavigationLink("", destination: Scanning(), isActive: $isShowingNextPage)
                        .hidden()
                }
                .navigationTitle("Chronology")
            }
        }
    }
}



#Preview {
    Chronology()
}
