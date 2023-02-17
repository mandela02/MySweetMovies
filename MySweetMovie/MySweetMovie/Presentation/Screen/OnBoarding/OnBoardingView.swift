//
//  OnBoardingView.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 23/11/2022.
//

import SwiftUI
import WebKit

struct OnBoardingView: View {
    var body: some View {
        Text(String.helloWorld)
            .foregroundColor(.white)
            .deviceAuthentication()
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
