//
//  MovieCollectionView.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI
import UnderlyingViewForSwiftUI
import Domain

struct MovieSection: GenericSection {
    let title: String = ""
    var data: [any Cell]
}

struct MovieCollectionView: View {
    @Binding
    var movies: [MovieSection]
    let onPullToRefresh: AsyncVoidCallback
    let onLoadMore: AsyncVoidCallback
    let onSelect: (Movie) -> Void
        
    var body: some View {
        UnderlyingCollectionView(data: movies,
                                 onRefesh: onPullToRefresh,
                                 onReachEnd: onLoadMore,
                                 calculateSizeForCell: { (_, _)  in .zero},
                                 buildCellForItem: { collectionView, indexPath in
            let section = movies[safe: indexPath.section]
            let data = section?.data[safe: indexPath.item]

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallMovieCollectionViewCell.className,
                                                                for: indexPath) as? SmallMovieCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let movie = data as? SingleCell<Movie> {
                cell.setup(movie: movie.model)
            }
            return cell
        },
                                 didSelectItem: { collectionView, indexPath in
            let section = movies[safe: indexPath.section]
            let data = section?.data[safe: indexPath.item] as? SingleCell<Movie>

            if let movie = data?.model {
                onSelect(movie)
            }
            
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
