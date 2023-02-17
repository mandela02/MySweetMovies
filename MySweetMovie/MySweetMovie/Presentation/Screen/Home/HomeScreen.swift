//
//  HomeScreen.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import SwiftUI
import SwiftUIExtension

struct HomeScreen: View {
    @StateObject
    var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            header
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
                .font(.system(size: 24, weight: .bold))
            Spacer()
            IconButton(icon: .magnifyingglass, action: {})
                .foregroundColor(.white)
        }
    }
}
