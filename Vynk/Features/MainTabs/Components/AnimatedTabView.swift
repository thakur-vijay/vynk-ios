//
//  AnimatedTabView.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import SwiftUI

struct AnimatedTabView<Content: TabContent<AnimatedTab>>: View {
    @Binding var selection: AnimatedTab
    @TabContentBuilder<AnimatedTab> var content: ()->Content
    var effects: (AnimatedTab)-> [any DiscreteSymbolEffect & SymbolEffect]
    @State private var imageViews: [AnimatedTab: UIImageView] = [:]
    
    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(.tabBarOnly)
        .background(
            ExtractImageViewsFromTabView {
                imageViews = $0
            }
        )
        .compositingGroup()
        .onChange(of: selection) { oldValue, newValue in
            let symbolEffects = effects(newValue)
            guard let imageView = imageViews[newValue] else { return }
            for effect in symbolEffects {
                imageView.addSymbolEffect(effect, options: .nonRepeating)
            }
        }
        
    }
}

fileprivate struct ExtractImageViewsFromTabView: UIViewRepresentable {
    var result: ([AnimatedTab: UIImageView])->()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            if let compositingGroup = view.superview?.superview {
                guard let tabHostingController = compositingGroup.subviews.last else { return }
                guard let tabController = tabHostingController.subviews.first?.next as? UITabBarController else { return }
                extractImageViews(tabController.tabBar)
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    private func extractImageViews(_ tabBar: UITabBar) {
        tabBar.tintColor = UIColor(AppColors.accent)
        let imageViews = tabBar.subviews(type: UIImageView.self)
            .filter { $0.image?.isSymbolImage ?? false }
            .filter { isiOS26 ? ($0.tintColor == tabBar.tintColor) : true}
        
        var dict: [AnimatedTab: UIImageView] = [:]
        for tab in AnimatedTab.allCases {
            if let imageView = imageViews.first(where: { $0.description.contains(tab.symbolImage)}){
                dict[tab] = imageView
            }
                
        }
        
        result(dict)
    }
    
    private var isiOS26: Bool {
        if #available(iOS 26, *){
            return true
        }
        
        return false
    }
}

fileprivate extension UIView {
    func subviews<T: UIView>(type: T.Type)->[T] {
        subviews.compactMap { $0 as? T } + subviews.flatMap { $0.subviews(type: type)}
    }
}

#Preview {
    MainTabView()
}
