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
        ZStack {
            Color.blackRussian
                .ignoresSafeArea()
                .opacity(0.0001)
            Image.movieAndSpeaker
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
                .foregroundColor(.white)
        }
        .background {
            Image.splashBackdrop
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .viewDidLoad(initState: {
            await genresManager.fetchDataFromApi()
            Application.shared.navigator?.setHomeViewController()
        })
    }
}
