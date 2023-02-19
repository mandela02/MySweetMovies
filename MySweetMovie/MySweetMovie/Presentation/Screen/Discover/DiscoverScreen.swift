//
//  DiscoverScreen.swift
//  MySweetMovie
//
//  Created by TriBQ on 18/02/2023.
//

import Foundation
import SwiftUI

struct DiscoverScreen: View {
    @StateObject
    var viewModel: DiscoverViewModel
    
    @EnvironmentObject
    var genresManager: GenresManager
    
    @State
    var isSelectingGenres = false
    
    var body: some View {
        VStack {
            header
                .padding(.horizontal, 20)
            gridView
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            if viewModel.state.genre == nil {
                isSelectingGenres = true
            }
        }
        .disableWhenLoading(loadingStatus: viewModel.state.loadingStatus)
        .loadingCircle(loadingStatus: $viewModel.state.loadingStatus)
        .reload(loadingStatus: $viewModel.state.loadingStatus,
                onRefresh: {
            await viewModel.fetchDataFromApi(genre: viewModel.state.genre)
        })
        .errorView(loadingStatus: $viewModel.state.loadingStatus)
        .overlay {
            if isSelectingGenres {
                genresListView
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isSelectingGenres)
    }
}

extension DiscoverScreen {
    private var header: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(String.discover)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                Spacer()
            }

            if let genre = viewModel.state.genre {
                HStack {
                    Text(genre.name)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .regular))
                    Image.chevronDown
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 16, height: 16)
                }
                .onTapGesture {
                    isSelectingGenres = true
                }
            }
        }
    }
    
    @ViewBuilder
    private var gridView: some View {
        MovieCollectionView(movies: $viewModel.state.movies,
                            onPullToRefresh: viewModel.pullToRefresh,
                            onLoadMore: {
            await viewModel.fetchDataFromApi(genre: viewModel.state.genre)
        },
                            onSelect: { movie in
            // viewModel.goToMovie(movieID: movie.id )
        })
    }

    private var genresListView: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(genresManager.movieGenres) { genre in
                    Text(genre.name)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .regular))
                        .onTapGesture(perform: {
                            isSelectingGenres = false
                            viewModel.onChangeGenres(genre: genre)
                        })
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .blurBackground()
    }
}
