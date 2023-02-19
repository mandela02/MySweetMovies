//
//  MovieCollectionViewModel.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUIExtension
import Domain
import IosUtilities

@MainActor
class MovieCollectionViewModel: BaseViewModel<MovieCollectionViewModel.State> {
    
    init(collection: MovieCollection,
         getMovieCollectinoUseCase: GetMovieCollectinoUseCase) {
        self.getMovieCollectinoUseCase = getMovieCollectinoUseCase
        super.init(state: State(collection: collection))
    }
    
    private let getMovieCollectinoUseCase: GetMovieCollectinoUseCase
    
    func fetchDataFromApi() async {
        do {
            state.movies[0].data = []
            let movies = try await getMovieCollectinoUseCase.run(input: .init(language: Settings.language.value,
                                                                              collectionID: state.collection.id))
            state.movies[0].data.append(contentsOf: movies.movie.map { SingleCell(model: $0) })

            state.overview = movies.overview
            state.loadingStatus = .success
        } catch {
            state.loadingStatus = .error(error.localizedDescription)
        }
    }
    
    struct State {
        let collection: MovieCollection
        var overview: String = ""
        var movies = [MovieSection(data: [])]
        var loadingStatus: LoadingStatus = .initial
    }
}
