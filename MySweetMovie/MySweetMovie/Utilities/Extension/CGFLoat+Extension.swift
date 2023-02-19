//
//  CGFLoat+Extension.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

extension CGFloat {
    var alwaysPositive: CGFloat {
        self > 0 ? self : .leastNonzeroMagnitude
    }
}
