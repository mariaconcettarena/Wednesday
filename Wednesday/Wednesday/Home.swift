//
//  Home.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home")
                
                NavigationLink(destination: Scanning()) {
                    Text("Go to Scanning")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
        }
    }
}


#Preview {
    Home()
}
