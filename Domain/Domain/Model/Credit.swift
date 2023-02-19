//
//  Credit.swift
//  Domain
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import Platform

public struct Credit: Identifiable {
    public let id: String = UUID().uuidString

    public var personId: Int
    public let name: String
    public let image: String
    public let character: String
    public let job: String
    public let creditID: String
    public let castID: Int
}

extension CreditEntity {
    var toModel: Credit {
        Credit(personId: self.id ?? -1,
               name: self.name ?? "",
               image: self.profilePath ?? "",
               character: self.character ?? "",
               job: self.job ?? "",
               creditID: self.creditID ?? "",
               castID: self.castID ?? -1)
    }
}
