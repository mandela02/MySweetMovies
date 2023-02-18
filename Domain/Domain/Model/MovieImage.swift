//
//  MovieImage.swift
//  Domain
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import Platform

public struct MovieImage: Identifiable {
    public var id: String = UUID().uuidString

    
    public let path: String
}

extension MovieImageEntity {
    var toModel: MovieImage {
        MovieImage(path: self.filePath ?? "")
    }
}
