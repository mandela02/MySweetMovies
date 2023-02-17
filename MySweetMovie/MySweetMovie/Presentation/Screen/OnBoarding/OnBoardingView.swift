//
//  OnBoardingView.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 23/11/2022.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject
    var genresManager: GenresManager
    
    var body: some View {
        Image.movieAndSpeaker
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200, alignment: .center)
            .background {
                Color.blackRussian
                    .ignoresSafeArea()
            }
            .viewDidLoad(initState: {
                await genresManager.fetchDataFromApi()
                Application.shared.navigator?.setHomeViewController()
            })
    }
}
