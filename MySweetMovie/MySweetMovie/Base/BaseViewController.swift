//
//  BaseViewController.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 13/12/2022.
//

import Foundation
import SwiftUIExtension
import SwiftUI

class BaseViewController<Content: View>: BaseHostingViewController<AnyView>, UIGestureRecognizerDelegate {
    
    init(rootView: Content) {
        let view = rootView
            .setEnvironment()
            .blackBackground()
            .eraseToAnyView()

        super.init(shouldShowNavigationBar: false, rootView: view)
    }
    
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

