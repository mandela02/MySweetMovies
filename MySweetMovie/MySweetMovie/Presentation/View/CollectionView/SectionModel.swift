//
//  SectionModel.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import UnderlyingViewForSwiftUI

struct SingleCell<T>: Cell {
    let model: T
}

struct ArrayCell<T>: Cell {
    let model: [T]
}

struct VoidSingleCell: Cell {}
