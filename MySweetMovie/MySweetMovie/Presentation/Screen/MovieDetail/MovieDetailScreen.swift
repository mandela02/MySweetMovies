//
//  MovieDetailScreen.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI
import SwiftUIExtension

struct MovieDetailScreen: View {
    @StateObject
    var viewModel: MovieDetailViewModel
    
    private let namedSpace = "SCROLL"

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: .leastNonzeroMagnitude) {
                    headerView

                    Color.clear.frame(height: 20)
                }
            }
            .coordinateSpace(name: namedSpace)
            .ignoresSafeArea(.container, edges: .vertical)
            
            ZStack {
                IconButton(icon: .chevronLeft,
                           action: {})
                .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .frame(height: 44)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            backgroundView
                .ignoresSafeArea()
                .blurOverlay()
        )
        .viewDidLoad(initState: viewModel.fetchDataFromApi)
        .disableWhenLoading(loadingStatus: viewModel.state.loadingStatus)
        .loadingCircle(loadingStatus: $viewModel.state.loadingStatus)
        .reload(loadingStatus: $viewModel.state.loadingStatus,
                onRefresh: viewModel.fetchDataFromApi)
        .errorView(loadingStatus: $viewModel.state.loadingStatus)
    }
}

extension MovieDetailScreen {
    @ViewBuilder
    private var headerView: some View {
        GeometryReader { outerProxy in
            GeometryReader { proxy in
                let minY = proxy.frame(in: .named(namedSpace)).minY
                let size = proxy.size
                let height = size.height + minY
        
                TabView {
                    ForEach(viewModel.state.detail?.backdrops ?? []) { image in
                        NetworkImage(url: image.path.tmdbOriginalImage,
                                     placeholderSize: 50)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
                .frame(width: size.width,
                       height: height > 0 ? height : .leastNonzeroMagnitude,
                       alignment: .top)
                .offset(y: -minY)
                .onChange(of: height) { newValue in
                    // viewModel.toggleNavigationBar(value: height < 0)
                }
            }
            .frame(height: outerProxy.size.width * 9 / 16)
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        if let image = viewModel.state.detail?.posterPath.tmdbImage {
            NetworkImage(url: image)
        } else {
            Color.blackRussian
        }
    }
}
