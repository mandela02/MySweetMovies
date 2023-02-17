//
//  BaseEntity.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 14/12/2022.
//

import Foundation
import CoreApiConcurrency

public struct DataEntity<T: Codable>: Codable {
    public let data: T?
    public let message: String?
}

// MARK: - Addition function
public extension DataEntity {
    func getData() throws -> T {
        if let message = message {
            throw  CustomError.serverMessage(message)
        }
        
        if let data = data {
            return data
        }
        
        throw CustomError.noData
    }
}
