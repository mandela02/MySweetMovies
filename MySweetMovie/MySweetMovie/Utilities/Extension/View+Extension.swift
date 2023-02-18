//
//  View+Extension.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 13/12/2022.
//

import Foundation
import SwiftUI
import IosUtilities
import SwiftUIExtension

extension View {
    
    @MainActor
    func setEnvironment() -> some View {
        self
            .environmentObject(Application.shared.internetManager)
            .environmentObject(Application.shared.biometricAuthenticationManager)
            .environmentObject(Application.shared.genresManager)
    }
    
    func deviceAuthentication() -> some View {
        self
            .modifier(AuthenticationModifier())
    }
    
    @ViewBuilder
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    @ViewBuilder
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
      background(
        GeometryReader { geometryProxy in
          Color.clear
            .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
        }
      )
      .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    var uiView: UIView {
        let view = UIHostingController(rootView: self).view
        return view ?? UIView()
    }
    
    @ViewBuilder
    func strikeThrought(color: Color) -> some View {
        ZStack {
            self
            
            color
                .frame(height: 2)
        }
        .fixedSize(horizontal: true, vertical: true)
    }
    
    @ViewBuilder
    func loadingCircle(loadingStatus: Binding<LoadingStatus>) -> some View {
        self
            .overlay(alignment: .center, content: {
                switch loadingStatus.wrappedValue {
                case .inProcess:
                    CircleLoadingView()
                default:
                    Color.clear
                }
            })
    }
    
    @ViewBuilder
    func loadingBar(loadingStatus: LoadingStatus) -> some View {
        self
            .overlay(alignment: .top, content: {
                switch loadingStatus {
                case .inProcess:
                    CircleLoadingView()
                default:
                    Color.clear
                }
            })
    }
    
    @ViewBuilder
    func clearWhenLoading(loadingStatus: LoadingStatus) -> some View {
        switch loadingStatus {
        case .success:
            self
        default:
            Color.clear
        }
    }
    
    @ViewBuilder
    func reload(loadingStatus: Binding<LoadingStatus>, onRefresh: @escaping AsyncVoidCallback) -> some View {
        self
            .overlay(alignment: .center, content: {
                switch loadingStatus.wrappedValue {
                case .error:
                    IconButton(icon: .arrowCounterclockwise,
                               size: .init(width: 50, height: 50)) {
                        Task { @MainActor in
                            await onRefresh()
                        }
                    }
                               .foregroundColor(.white)
                               .frame(width: 100, height: 100)
                               .contentShape(Rectangle())
                default:
                    Color.clear
                }
            })
    }
    
    @ViewBuilder
    func errorView(loadingStatus: Binding<LoadingStatus>) -> some View {
        self
            .modifier(ErrorViewModifier(loadingStatus: loadingStatus))
    }
    
    @ViewBuilder
    func viewDidLoad(initState: @escaping AsyncVoidCallback) -> some View {
        self
            .modifier(ViewDidLoadModifier(initState: initState))
    }
    
    @ViewBuilder
    func navigationBar<Content: View>(child: Content) -> some View {
        VStack(spacing: 0) {
            child
                .frame(maxWidth: .infinity)
            
            self
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func backgroundColor(color: Color) -> some View {
        ZStack(alignment: .top) {
            color
                .ignoresSafeArea()
            
            self
        }
    }
    
    @ViewBuilder
    func blackBackground() -> some View {
        backgroundColor(color: .blackRussian)
    }
    
    @ViewBuilder
    func disableWhenLoading(loadingStatus: LoadingStatus) -> some View {
        self
            .disabled(loadingStatus == .inProcess)
    }
    
    @ViewBuilder
    func shadowMountainBackground() -> some View {
        self
            .background(
                Color.shadowMountain.opacity(0.3)
                    .cornerRadius(10)
            )
    }
    
    @ViewBuilder
    func authentication() -> some View {
        self
            .modifier(AuthenticationModifier())
    }
    
    @ViewBuilder
    var plainButton: some View {
        self.buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    func toast(isShowing: Binding<Bool>, message: String) -> some View {
        self
            .modifier(ToastViewModifier(isShowing: isShowing, message: message))
    }
    
    @ViewBuilder
    func errorAlert(isShowing: Binding<Bool>, message: String) -> some View {
        self
            .modifier(ErrorAlertViewModifier(isShowing: isShowing, errorMessage: message))
    }
    
    @ViewBuilder
    func clearListCell() -> some View {
        self
            .listRowSeparatorTint(.clear)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

    }
    
    @ViewBuilder
    func blurOverlay() -> some View {
        ZStack {
            self
            Color.black
                .ignoresSafeArea()
                .opacity(0.8)
                .background(
                    .ultraThinMaterial
                )
        }
    }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
