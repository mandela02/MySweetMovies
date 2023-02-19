//
//  SearchBar.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI

struct SearchBarView: View {
    @Binding
    var searchText: String
    
    var placeholder: String
    
    var backgroudColor: Color
    
    var isFocus: FocusState<Bool>.Binding

    var body: some View {
        HStack {
            TextField("",
                      text: $searchText)
            .focused(isFocus)
            .font(.system(size: 11, weight: .bold))
            .foregroundColor(.white)
            .lineLimit(1)
            .frame(maxWidth: .infinity)
            .accentColor(.philipineGray)
            .placeholder(when: searchText.isEmpty,
                         placeholder: {
                Text(placeholder)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.philipineGray)
                    .lineLimit(1)
            })
            
            Image.magnifyingglass
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
        .background(
            backgroudColor
                .cornerRadius(5)
        )
    }
}
