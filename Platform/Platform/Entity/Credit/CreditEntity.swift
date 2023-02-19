//
//  CreditEntity.swift
//  Platform
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation

public struct CreditEntity: Codable {
    public let adult: Bool?
    public let gender, id: Int?
    public let knownForDepartment: String?
    public let name, originalName: String?
    public let popularity: Double?
    public let profilePath: String?
    public let castID: Int?
    public let character, creditID: String?
    public let order: Int?
    public let department: String?
    public let job: String?

    public enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
