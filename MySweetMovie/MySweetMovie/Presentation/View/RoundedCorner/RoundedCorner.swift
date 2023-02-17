//
//  RoundedCorner.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI

public struct RoundedCorner: Shape {
    public init(radius: CGFloat = .infinity,
                corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    private var radius: CGFloat
    private var corners: UIRectCorner

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
