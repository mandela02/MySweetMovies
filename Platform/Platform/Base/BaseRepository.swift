//
//  BaseRepository.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 15/12/2022.
//

import Foundation
import CoreApiConcurrency

public class BaseRepository<Data: Codable> {
    init(endpoint: String) {
        self.endpoint = endpoint
    }

    var endpoint: String

    lazy var dataRepository = ApiRepository<DataEntity<Data>>(endpoint)
}
