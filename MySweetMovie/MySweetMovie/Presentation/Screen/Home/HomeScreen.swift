//
//  HomeScreen.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import SwiftUI
import SwiftUIExtension
import UnderlyingViewForSwiftUI
import Domain

struct HomeScreen: View {
    @StateObject
    var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            header
                .padding(.horizontal, 20)
            gridView
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

extension HomeScreen {
    private var header: some View {
        HStack {
            Text(String.home)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
            Spacer()
            IconButton(icon: .magnifyingglass, action: {})
                .foregroundColor(.white)
        }
    }
    
    private var gridView: some View {
        UnderlyingCollectionView(data: viewModel.state.sections,
                                 onRefesh: viewModel.pullToRefresh,
                                 calculateSizeForCell: { (_, _)  in .zero},
                                 buildCellForItem: { collectionView, indexPath in
            let section = viewModel.state.sections[indexPath.section]
            let data = section.data[indexPath.item]
            
            switch section.type {
            case .big:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigMovieCollectionViewCell.className,
                                                                    for: indexPath) as? BigMovieCollectionViewCell,
                      let movie = data as? SingleCell<Movie> else {
                    return UICollectionViewCell()
                }

                cell.setup(movie: movie.model)
                return cell
            case .small:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallMovieCollectionViewCell.className,
                                                                    for: indexPath) as? SmallMovieCollectionViewCell,
                      let movie = data as? SingleCell<Movie> else {
                    return UICollectionViewCell()
                }

                cell.setup(movie: movie.model)
                return cell
            }

        },
                                 buildHeader: { collectionView, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                             withReuseIdentifier: HeaderCollectionReusableView.className,
                                                                             for: indexPath) as? HeaderCollectionReusableView
            let section = viewModel.state.sections[indexPath.section]
            headerView?.onMoreButtonTapped = {}
            headerView?.setupView(title: section.title)
            return headerView ?? UICollectionReusableView()
        },
                                 extraSetting: { collectionView in
            collectionView.collectionViewLayout = buildCompositeLayout()
            collectionView.backgroundColor = .clear
            
            collectionView.register(BigMovieCollectionViewCell.self,
                                    forCellWithReuseIdentifier: BigMovieCollectionViewCell.className)
            collectionView.register(SmallMovieCollectionViewCell.self,
                                    forCellWithReuseIdentifier: SmallMovieCollectionViewCell.className)
            collectionView.register(HeaderCollectionReusableView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: HeaderCollectionReusableView.className)
        })
    }
}

extension HomeScreen {
    private func buildCompositeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = viewModel.state.sections[safe: section] else {
                return LayoutBuilder.defaultVertical()
            }
            
            var layoutSection: NSCollectionLayoutSection?
            
            switch section.type {
            case .big:
                let width = (environment.container.contentSize.width - 20 * 2) - 50

                layoutSection = LayoutBuilder.buildHorizontalScrollSectionLayout(itemSize: .init(widthDimension: .fractionalWidth(1),
                                                                                                 heightDimension: .fractionalHeight(1)),
                                                                                 layoutSize: .init(widthDimension: .absolute(width),
                                                                                                   heightDimension: .absolute(width * 9 / 16)))
            case .small:
                let width = (environment.container.contentSize.width - 20 * 2 - 20) / 2 - 30
                layoutSection = LayoutBuilder.buildHorizontalScrollSectionLayout(itemSize: .init(widthDimension: .fractionalWidth(1),
                                                                                                 heightDimension: .fractionalHeight(1)),
                                                                                 layoutSize: .init(widthDimension: .absolute(width),
                                                                                                   heightDimension: .absolute(width * 3 / 2)))
            }
            
            if !section.title.isEmpty {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(20))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .topLeading)
                layoutSection?.boundarySupplementaryItems = [header]
            }
            return layoutSection
        }
        
        return layout
    }
}
