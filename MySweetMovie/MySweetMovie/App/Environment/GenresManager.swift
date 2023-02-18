//
//  GenresManager.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import Domain
import Combine

@MainActor
class GenresManager: ObservableObject {

    init(getGenresUseCase: GetGenresUseCase) {
        self.getGenresUseCase = getGenresUseCase
            
        NotificationCenter.default.publisher(for: .languageDidChange)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                Task {
                    await self.fetchDataFromApi()
                }
            }
            .store(in: &cancellables)
    }
    
    let getGenresUseCase: GetGenresUseCase
    
    public var cancellables = Set<AnyCancellable>()

    @Published
    var movieGenres: [Genre] = []
    
    @Published
    var tvGenres: [Genre] = []
    
    func fetchDataFromApi() async {
        do {
            let result = try await getGenresUseCase.run(input: Settings.language.value)
            self.movieGenres = result.movieGenres
            self.tvGenres = result.tvGenres
            NotificationCenter.default
                .post(name: .genresDidChange,
                      object: nil)
        } catch {
            debugPrint(error)
        }
    }
}
