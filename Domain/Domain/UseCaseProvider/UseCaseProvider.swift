//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import Platform

public struct UseCaseProvider: UseCaseProviderProtocol {
    private let provider: RepositoryProvider
    
    public init(repositoryProvider: RepositoryProvider = RepositoryProvider()) {
        self.provider = repositoryProvider
    }
    
    public func loginUseCase() -> LoginUseCase {
        LoginUseCase(loginRepository: provider.makeLoginRepository())
    }
}
