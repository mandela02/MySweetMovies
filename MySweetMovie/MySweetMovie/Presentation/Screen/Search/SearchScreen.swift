//
//  SearchScreen.swift
//  MySweetMovie
//
//  Created by TriBQ on 18/02/2023.
//

import Foundation
import SwiftUI

struct SearchScreen: View {
    @StateObject
    var viewModel: SearchViewModel
    
    @FocusState
    private var isFocus: Bool

    var body: some View {
        VStack {
            header
                .padding(.horizontal, 20)
            searchBarView
                .padding(.horizontal, 20)
            gridView
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .viewDidLoad(initState: {
            await viewModel.fetchDataFromApi(keyword: "")
        })
        .disableWhenLoading(loadingStatus: viewModel.state.loadingStatus)
        .loadingCircle(loadingStatus: $viewModel.state.loadingStatus)
        .reload(loadingStatus: $viewModel.state.loadingStatus,
                onRefresh: {
            await viewModel.fetchDataFromApi(keyword: "")
        })
        .errorView(loadingStatus: $viewModel.state.loadingStatus)
    }
}

extension SearchScreen {
    private var header: some View {
        HStack(spacing: 14) {
            Text(String.search)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Spacer()
        }
    }

    private var searchBarView: some View {
        SearchBarView(searchText: $viewModel.state.query,
                      placeholder: .searchMovie,
                      backgroudColor: .shadowMountain.opacity(0.3),
                      isFocus: $isFocus)
    }
    
    @ViewBuilder
    private var gridView: some View {
        MovieCollectionView(movies: $viewModel.state.movies,
                            onPullToRefresh: viewModel.pullToRefresh,
                            onLoadMore: {
            await viewModel.fetchDataFromApi(keyword: viewModel.state.query)
        },
                            onSelect: { movie in
            if isFocus {
                return
            }
            viewModel.goToMovie(movieID: movie.id )
        })
    }
}
