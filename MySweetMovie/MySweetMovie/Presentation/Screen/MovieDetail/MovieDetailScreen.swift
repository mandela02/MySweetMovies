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
    
    @State
    private var width: CGFloat = .leastNonzeroMagnitude

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: .leastNonzeroMagnitude) {
                    headerView
                    Color.clear.frame(height: 10)
                    nameView
                    Color.clear.frame(height: 20)
                    posterView
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
    private var headerView: some View {
        ZStack(alignment: .bottom) {
            headerImagesView
            
            HStack {
                Text(viewModel.state.detail?.releaseDate.year.asString ?? Date().year.asString)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .backgroundColor(.roseBonbon)
                    .clipShape(Capsule())
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    RateView(rate: viewModel.state.detail?.voteAverage ?? 0, size: 10)
                    
                    Text((viewModel.state.detail?.voteCount ?? 0).asString + " " + .vote)
                        .foregroundColor(.philipineGray)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                Text(viewModel.state.detail?.voteAverage.oneDigitString ?? "")
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    Color.blackRussian.opacity(.leastNonzeroMagnitude),
                    Color.blackRussian
                ]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
        }
    }
    
    private var nameView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.state.detail?.title ?? "")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Text(viewModel.state.detail?.originalTitle ?? "")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.philipineGray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }
    
    private var posterView: some View {
        let imageWidth = (width / 2 - 40).alwaysPositive
        
        return HStack(alignment: .top) {
            Label {
                Text("\((viewModel.state.detail?.runtime ?? 0).asString) \(.min)")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .regular))
            } icon: {
                Image.clockCircle
                    .resizable()
                    .foregroundColor(.roseBonbon)
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 16, height: 16)
            }
            
            Spacer()
            
            TabView {
                ForEach(viewModel.state.detail?.posters ?? []) { image in
                    NetworkImage(url: image.path.tmdbOriginalImage,
                                 placeholderSize: 20)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .frame(width: imageWidth, height: imageWidth * 3 / 2)
            .cornerRadius(8)
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var headerImagesView: some View {
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
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .frame(width: size.width,
                   height: height > 0 ? height : .leastNonzeroMagnitude,
                   alignment: .top)
            .offset(y: -minY)
            .onChange(of: height) { newValue in
                // viewModel.toggleNavigationBar(value: height < 0)
            }
            .onAppear(perform: {
                width = proxy.size.width
            })
        }
        .frame(height: width * 9 / 16)
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
