//
//  MovieCollectionView.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI
import SwiftUIExtension
import Domain

struct MovieCollectionScreen: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    @StateObject
    var viewModel: MovieCollectionViewModel
    
    let onSelect: (Movie) -> Void
    
    @State
    var height: CGFloat = .leastNonzeroMagnitude
    
    var body: some View {
        VStack(spacing: 10) {
            navigationView
            posterView
            MovieCollectionView(movies: $viewModel.state.movies,
                                onPullToRefresh: viewModel.fetchDataFromApi,
                                onLoadMore: {},
                                onSelect: onSelect)
            .frame(maxHeight: .infinity)
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

extension MovieCollectionScreen {
    private var navigationView: some View {
        HStack(spacing: 14) {
            IconButton(icon: .x,
                       action: {
                presentationMode.wrappedValue.dismiss()
            })
            .foregroundColor(.white)

            Text(viewModel.state.collection.name)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
                .padding(.leading, 20)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    
    private var posterView: some View {
        GeometryReader { proxy in
            let imageWidth = (proxy.size.width / 2 - 40).alwaysPositive

            HStack(alignment: .top) {
                Text(viewModel.state.overview )
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)

                Spacer()
                
                NetworkImage(url: viewModel.state.collection.posterPath.tmdbOriginalImage,
                             placeholderSize: 20,
                             placeholderText: viewModel.state.collection.name)
                .frame(width: imageWidth, height: imageWidth * 3 / 2)
                .cornerRadius(8)
            }
            .padding(.horizontal, 10)
            .onAppear {
                self.height = imageWidth * 3 / 2
            }
        }
        .frame(height: height)
    }
}
