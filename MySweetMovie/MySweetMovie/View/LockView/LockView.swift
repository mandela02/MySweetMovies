//
//  LockView.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 13/12/2022.
//

import Foundation
import SwiftUI
import SwiftUIExtension

struct LockView: View {
    var body: some View {
        VStack {
            Text(String.locked)
            SizedBox(height: 100)
            Text(String.scanFaceID)
                .fixedSize(horizontal: true, vertical: false)
                .lineLimit(1)
        }
        .foregroundColor(Color.white)
        .blackBackground()
    }
}


struct LockView_Previews: PreviewProvider {
    static var previews: some View {
        LockView()
    }
}
