//
//  Color+Extension.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 14/12/2022.
//

import Foundation
import SwiftUI

// MARK: - Theme
enum Theme: Int, CaseIterable {
    case freshOrange
    
    private var themeColor: ThemeColor {
        ThemeColor.themeConfiguration[self] ?? .freshOrange
    }
    
    static var current: ThemeColor {
        return Theme(rawValue: Settings.theme.value)?.themeColor ?? Theme.freshOrange.themeColor
    }
    
    static func post(themeId: Int) {
        Settings.theme.value = themeId
        NotificationCenter.default
            .post(name: .themeDidChange,
                  object: nil)
    }
}

// MARK: - Theme Color
struct ThemeColor {
    let englishDaisy: String
    let roseBonbon: String
    let philipineGray: String
    let bastelle: String
    let shadowMountain: String
    let blackRussian: String
    let darkGray: String
    let nearSilver: String
    let dullBlack: String
    let eerieBlack: String
    let fennelFiesta: String
    let eyelashViper: String
    let seaBuckthorn: String
    let purpleSand: String
    let emeraldReflection: String
}

extension ThemeColor {
    static let themeConfiguration: [Theme: ThemeColor]  = [.freshOrange: .freshOrange]
}

extension ThemeColor {
    static let freshOrange = ThemeColor(englishDaisy: "FFCB48",
                                        roseBonbon: "FA683A",
                                        philipineGray: "8C8C92",
                                        bastelle: "2B2B30",
                                        shadowMountain: "585858",
                                        blackRussian: "18181F",
                                        darkGray: "515151",
                                        nearSilver: "B9B9BF",
                                        dullBlack: "161616",
                                        eerieBlack: "1E1E1E",
                                        fennelFiesta: "00CD77",
                                        eyelashViper: "F2C94C",
                                        seaBuckthorn: "F2994A",
                                        purpleSand: "854FF9",
                                        emeraldReflection: "4ECB71")
}

// MARK: - Color
extension Color {
    static var englishDaisy: Color { Theme.current.englishDaisy.color }
    static var roseBonbon: Color { Theme.current.roseBonbon.color }
    static var philipineGray: Color { Theme.current.philipineGray.color }
    static var bastelle: Color { Theme.current.bastelle.color }
    static var shadowMountain: Color { Theme.current.shadowMountain.color }
    static var blackRussian: Color { Theme.current.blackRussian.color }
    static var darkGray: Color { Theme.current.darkGray.color }
    static var dullBlack: Color { Theme.current.dullBlack.color }
    static var eerieBlack: Color { Theme.current.eerieBlack.color }
    static var fennelFiesta: Color { Theme.current.fennelFiesta.color }
    static var eyelashViper: Color { Theme.current.eyelashViper.color }
    static var nearSilver: Color { Theme.current.nearSilver.color }
    static var seaBuckthorn: Color { Theme.current.seaBuckthorn.color }
    static var purpleSand: Color { Theme.current.purpleSand.color }
    static var emeraldReflection: Color { Theme.current.emeraldReflection.color }
}

