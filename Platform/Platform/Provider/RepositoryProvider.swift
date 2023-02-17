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
    
    public lazy var genresRepository = GenresRepository(endpoint: self.apiEndpoint)
    public lazy var moviesRepository = MoviesRepository(endpoint: self.apiEndpoint)
}
