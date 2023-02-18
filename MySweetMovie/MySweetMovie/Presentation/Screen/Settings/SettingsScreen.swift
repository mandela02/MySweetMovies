//
//  SettingsScreen.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import SwiftUI

struct SettingsScreen: View {
    
    @AppStorage(SettingKey.language.rawValue)
    private var language = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(String.setting)
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                Spacer()
            }
            .padding(.horizontal, 20)

            VStack(alignment: .leading, spacing: 1) {
                ForEach(LanguageCode.allCases) { code in
                    Text(code.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.all, 20)
                        .onTapGesture {
                            if language != code.rawValue {
                                code.changeLanguage()
                            }
                        }
                }
            }
            .shadowMountainBackground()
            .cornerRadius(14)
            .padding(.all, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .blackBackground()
        .id(language)
    }
}
