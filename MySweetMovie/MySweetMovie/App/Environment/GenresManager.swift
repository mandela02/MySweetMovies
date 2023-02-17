//
//  GenresManager.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import Domain
import Combine

class GenresManager: ObservableObject {

    init(getGenresUseCase: GetGenresUseCase) {
        self.getGenresUseCase = getGenresUseCase
        
        fetchDataFromApi()
        
        NotificationCenter.default.publisher(for: .languageDidChange)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.fetchDataFromApi()
            }
            .store(in: &cancellables)
    }
    
    let getGenresUseCase: GetGenresUseCase
    
    public var cancellables = Set<AnyCancellable>()

    @Published
    var movieGenres: [Genre] = []
    
    @Published
    var tvGenres: [Genre] = []
    
    func fetchDataFromApi() {
        Task {
            do {
                let result = try await getGenresUseCase.run(input: Settings.language.value)
                self.movieGenres = result.movieGenres
                self.tvGenres = result.tvGenres
            } catch {
                debugPrint(error)
            }
        }
    }
}
