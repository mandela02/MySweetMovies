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

    private var gridView: some View {
        UnderlyingCollectionView(data: viewModel.state.movies,
                                 onRefesh: viewModel.pullToRefresh,
                                 onReachEnd: viewModel.fetchDataFromApi,
                                 calculateSizeForCell: { (_, _)  in .zero},
                                 buildCellForItem: { collectionView, indexPath in
            let section = viewModel.state.movies[indexPath.section]
            let data = section.data[indexPath.item]

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallMovieCollectionViewCell.className,
                                                                for: indexPath) as? SmallMovieCollectionViewCell,
                  let movie = data as? SingleCell<Movie> else {
                return UICollectionViewCell()
            }

            cell.setup(movie: movie.model)
            return cell
        },
                                 extraSetting: { collectionView in
            collectionView.collectionViewLayout = buildCompositeLayout()
            collectionView.backgroundColor = .clear
            collectionView.register(SmallMovieCollectionViewCell.self,
                                    forCellWithReuseIdentifier: SmallMovieCollectionViewCell.className)
            
        })
    }
    
    private func buildCompositeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let width = environment.container.contentSize.width
            let cellWidth = (width - 20 * 4) / 3
            let layoutSection = LayoutBuilder.buildVerticalGridLayout(itemSize: .init(widthDimension: .fractionalWidth(1 / 3),
                                                                                      heightDimension: .fractionalHeight(1)),
                                                                      groupSize: .init(widthDimension: .fractionalWidth(1),
                                                                                       heightDimension: .absolute(cellWidth * 3 / 2)),
                                                                      column: 3)
            return layoutSection
        }
        
        return layout
    }
}
