//
//  LoginResponseEntity.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 14/12/2022.
//

import Foundation

public struct LoginResponseEntity: Codable {
    public let status: Bool
    public let accessToken: String
    public let refreshToken: String
}
