//
//  HeaderView.swift
//  MySweetMovie
//
//  Created by TriBQ on 17/02/2023.
//

import Foundation
import SwiftUI
import IosUtilities

class HeaderCollectionReusableView: UICollectionReusableView {
    var onMoreButtonTapped: VoidCallback?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.removeAllSubviews()
    }
    
    func setupView(title: String) {
        let headerView = ShopHeaderView(title: title,
                                        onTap: onMoreButtonTapped).uiView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerView)
        self.backgroundColor = .clear
        headerView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

struct ShopHeaderView: View {
    let title: String
    let onTap: VoidCallback?
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(.white)
            
            Spacer()
            
            if let onTap = onTap {
                UnderlineButton(title: .viewAll, onTap: onTap)
            }
        }
    }
}
