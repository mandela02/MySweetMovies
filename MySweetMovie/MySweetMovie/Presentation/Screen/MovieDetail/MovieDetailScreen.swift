//
//  MovieDetailScreen.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI

struct MovieDetailScreen: View {
    @StateObject
    var viewModel: MovieDetailViewModel
    
    var body: some View {
        ZStack {
            Image.splashBackdrop
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .blackBackground()
        .viewDidLoad(initState: viewModel.fetchDataFromApi)
    }
}
