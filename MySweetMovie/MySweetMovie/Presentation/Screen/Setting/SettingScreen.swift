//
//  SettingScreen.swift
//  MySweetMovie
//
//  Created by Tri Bui Q. VN.Hanoi on 17/02/2023.
//

import Foundation
import SwiftUI

struct SettingScreen: View {
    
    @AppStorage(SettingKey.language.rawValue)
    private var language = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            ForEach(LanguageCode.allCases) { code in
                Text(code.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.all, 8)
                    .onTapGesture {
                        if language != code.rawValue {
                            code.changeLanguage()
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .blackBackground()
        .id(language)
    }
}
