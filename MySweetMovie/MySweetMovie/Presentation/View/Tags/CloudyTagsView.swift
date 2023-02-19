//
//  CloudyTagsView.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI

struct CloudyTagView: View {
    internal init(tags: [String],
                  background: Color? = nil,
                  foreground: Color? = nil,
                  selected: Binding<String>) {
        self.tags = tags
        self.background = background
        self.foreground = foreground
        self._selected = selected
    }
    
    var tags: [String]
    var background: Color?
    var foreground: Color?

    @Binding
    var selected: String
    
    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight) // << variant for ScrollView/List
        // .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > g.size.width {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 // last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String) -> some View {
        TextTag(title: text,
                background: background ?? (self.selected == text ? .roseBonbon : Color.shadowMountain.opacity(0.3)),
                foreground: foreground ?? (self.selected == text ? .white : .nearSilver))
        .onTapGesture {
            self.selected = text
        }
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

struct TextTag: View {
    let title: String
    let background: Color
    let foreground: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(background.cornerRadius(4))
            .foregroundColor(foreground)
            .lineLimit(1)
    }
}
