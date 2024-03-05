//
//  Colors.swift
//  Wednesday
//
//  Created by Maria Concetta on 14/02/24.
//

//import Foundation
import SwiftUI

let sfondo = Color(red: 244.0/255.0, green: 250.0/255.0, blue: 248.0/255.0)

let verde = Color(red: 82/255, green: 114/255, blue: 94/255)

let verdeCard = Color(red: 225/255, green: 234/255, blue: 226/255)

// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// Custom RoundedCorner shape used for cornerRadius extension above
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
