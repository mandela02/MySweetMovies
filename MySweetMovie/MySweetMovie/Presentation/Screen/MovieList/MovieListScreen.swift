//
//  MovieListScreen.swift
//  MySweetMovie
//
//  Created by TriBQ on 18/02/2023.
//

import Foundation
import SwiftUI
import UnderlyingViewForSwiftUI
import Domain
import SwiftUIExtension

struct MovieListScreen: View {
    @StateObject
    var viewModel: MovieListViewModel
    
    var body: some View {
        VStack {
            header
                .padding(.horizontal, 20)
            gridView
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .viewDidLoad(initState: {
            await viewModel.fetchDataFromApi()
        })
        .disableWhenLoading(loadingStatus: viewModel.state.loadingStatus)
        .loadingCircle(loadingStatus: $viewModel.state.loadingStatus)
        .reload(loadingStatus: $viewModel.state.loadingStatus,
                onRefresh: viewModel.fetchDataFromApi)
        .errorView(loadingStatus: $viewModel.state.loadingStatus)

    }
}

extension MovieListScreen {
    private var header: some View {
        HStack(spacing: 14) {
            IconButton(icon: .chevronLeft,
                       action: {
                self.viewModel.back()
            })
            .foregroundColor(.white)
            
            Text(viewModel.state.kind.name)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Spacer()
        }
    }

    @ViewBuilder
    private var gridView: some View {
        MovieCollectionView(movies: $viewModel.state.movies,
                            onPullToRefresh: viewModel.pullToRefresh,
                            onLoadMore: viewModel.fetchDataFromApi,
                            onSelect: { viewModel.goToMovie(movieID: $0.id )})
    }
}
