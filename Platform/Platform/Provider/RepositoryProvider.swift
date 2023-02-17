//
//  RepositoryProvider.swift
//  Platform
//
//  Created by Tri Bui Q. VN.Hanoi on 15/12/2022.
//

import Foundation

public class RepositoryProvider {
    public init() {
        self.apiEndpoint = String.endpoint
    }
    
    private let apiEndpoint: String

    private var loginRepository: LoginRepository?

    public func makeLoginRepository() -> LoginRepository {
        if let loginRepository = loginRepository {
            return loginRepository
        }
        self.loginRepository = LoginRepository(endpoint: self.apiEndpoint)
        return loginRepository!
    }
}
