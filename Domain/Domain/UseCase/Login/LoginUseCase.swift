//
//  LoginUseCase.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 15/12/2022.
//

import Foundation
import Platform

public struct LoginUseCase: InputUseCaseProtocol {
    public typealias Input = LoginUseCaseInput
    
    public struct LoginUseCaseInput {
        let userName: String
        let password: String
    }
    
    public init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
    }
    
    private let loginRepository: LoginRepository


    public func run(input: LoginUseCaseInput) async throws {
    }
}
