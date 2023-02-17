//
//  BaseUseCase.swift
//  Domain
//
//  Created by Tri Bui Q. VN.Hanoi on 15/12/2022.
//

import Foundation

public protocol VoidUseCaseProtocol {
     func run() async throws
}

public protocol OutputUseCaseProtocol {
    associatedtype Output
    func run() async throws -> Output
}

public protocol InputUseCaseProtocol {
    associatedtype Input
    func run(input: Input) async throws
}


public protocol InputOutputUseCaseProtocol {
    associatedtype Output
    associatedtype Input
    func run(input: Input) async throws -> Output
}

