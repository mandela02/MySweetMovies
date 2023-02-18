//
//  CheckOutScreen.swift
//  MySweetMovie
//
//  Created by TriBQ on 19/02/2023.
//

import Foundation
import SwiftUI
import WebKit
import SwiftUIExtension

struct CheckOutView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        WebView(url: "https://www.gv.com.sg/")
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
            .blackBackground()
            .navigationBar(child: header)
    }
    
    private var header: some View {
        HStack(spacing: 14) {
            IconButton(icon: .chevronLeft,
                       action: {
                presentationMode.wrappedValue.dismiss()
            })
            .foregroundColor(.white)
            
            Text(String.orderNow)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            Color.eerieBlack
                .ignoresSafeArea(.container, edges: .top)
        )
    }
}

struct WebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scalesLargeContentImage = true
        
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        
        let config = WKWebViewConfiguration()
        config.dataDetectorTypes = [.all]
        
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if context.coordinator.data == url {
            return
        }
        
        context.coordinator.data = url
        
        if let url = URL(string: url) {
            // BUG
            // https://developer.apple.com/forums/thread/713290
            DispatchQueue.main.async {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var data = ""
    }
}
