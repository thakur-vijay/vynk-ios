//
//  GlassSegmentedControl.swift
//  Vynk
//
//  Created by Vijay Thakur on 09/06/26.
//

import SwiftUI

struct GlassSegmentedControl: View {
    var config: Config = .init()
    @Binding var selection: Int
    @Binding var tabs: [Self.Tab]
    
    @State private var activeIndex: Int?
    @State private var scrollPosition: ScrollPosition = .init()
    @State private var scrollPhase: ScrollPhase = .idle
    var body: some View {
        GeometryReader {
            let containerSize = $0.size
            let activeSize = tabs[activeIndex ?? 0].viewSize
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach($tabs) { $tab in
                        Text(tab.title)
                            .foregroundStyle(config.foregroundStyle)
                            .font(.system(size: 16))
                            .padding(.horizontal, (config.refractionDepth + 3))
                            .frame(height: containerSize.height)
                            .onGeometryChange(for: CGSize.self) {
                                $0.size
                            } action: { newValue in
                                tab.viewSize = newValue
                            }
                            .contentShape(.rect)
                            .onTapGesture {
                                if let index = tabs.firstIndex(where: { $0.id == tab.id}){
                                    selection = index
                                }
                            }
                    }
                }
                .overlay {
                    HStack(spacing: 0) {
                        ForEach($tabs) { $tab in
                            Text(tab.title)
                                .font(.system(size: 16))
                                .foregroundStyle(config.tint)
                                .padding(.horizontal, (config.refractionDepth + 3))
                                .frame(height: containerSize.height)
                        }
                    }
                    .mask(alignment: .leading) {
                        Capsule()
                            .frame(activeSize)
                            .visualEffect { content, proxy in
                                let midX = proxy.frame(in: .scrollView).midX
                                return content
                                    .offset(x: -midX)
                            }
                    }
                    .allowsHitTesting(false)
                }
                .visualEffect {[config]
                    content,
                    proxy in
                    let rect = proxy.frame(in: .scrollView)
                    let minX = rect.minX + (activeSize.width / 2)
                    return content
                        .layerEffect(
                            ShaderLibrary.liquidLens(
                                .float2(activeSize),
                                .float(-minX),
                                .float(config.refractionAmount),
                                .float(config.refractionDepth)
                            ),
                            maxSampleOffset: .init(width: 200, height: 100)
                        )
                }
                .background(alignment: .leading) {
                    ZStack {
                        Capsule()
                            .fill(.clear)
                            .frame(activeSize)
                            .background {
                                if #available(iOS 26, *) {
                                    Capsule()
                                        .fill(.clear)
                                        .glassEffect(.regular, in: .capsule)
                                } else {
                                    Capsule()
                                        .fill(.ultraThinMaterial)
                                }
                            }
                    }
                    .frame(activeSize)
                    .visualEffect { content, proxy in
                        let midX = proxy.frame(in: .scrollView).midX
                        return content
                            .offset(x: -midX)
                    }
                }
                .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.3, blendDuration: 0.4), value: activeIndex)

            }
            .scrollIndicators(.hidden)
            .safeAreaPadding(.horizontal, (containerSize.width / 2))
            .scrollTargetBehavior(CustomScrollTarget(tabs: $tabs))
            .scrollPosition($scrollPosition, anchor: .center)
            .onScrollGeometryChange(for: CGFloat.self) {
                $0.contentOffset.x + $0.contentInsets.leading
            } action: { oldValue, newValue in
                if let index = tabs.closestSnapPointIndex(newValue), activeIndex != nil{
                    activeIndex = index
                    if scrollPhase != .animating {
                        selection = index
                    }
                }
            }
            .onScrollPhaseChange { oldPhase, newPhase in
                scrollPhase = newPhase
            }

        }
        .frame(height: 50)
        .padding(.top, AppSpacing.lg)
        .background(.black.opacity(0.5))
        .allowsHitTesting(scrollPhase != .animating)
        .task {
            let cappedIndex = max(min(selection, tabs.count - 1), 0)
            selection = cappedIndex
            activeIndex = cappedIndex
        }
        .onChange(of: selection) { oldValue, newValue in
            if activeIndex != newValue {
                let cappedIndex = max(min(selection, tabs.count - 1), 0)
                withAnimation(.snappy) {
                    scrollPosition.scrollTo(x: tabs.snapPoints[cappedIndex])
                }
            }
        }
        .onChange(of: tabs.map(\.viewSize)) { _, sizes in
            guard activeIndex != nil else { return }
            guard sizes.allSatisfy({ $0 != .zero }) else { return }
            let cappedIndex = max(min(selection, tabs.count - 1), 0)
            DispatchQueue.main.async {
                scrollPosition.scrollTo(x: tabs.snapPoints[cappedIndex])
            }

        }
    }
    
    struct Config {
        var foregroundStyle: Color = .white
        var tint: Color = .yellow
        var refractionAmount: CGFloat = 10
        var refractionDepth: CGFloat = 17
    }
    
    struct Tab: Identifiable {
        var title: String
        fileprivate var viewSize: CGSize = .zero
        
        init(title: String) {
            self.title = title
        }
        
        var id: String { title }
    }
}

fileprivate extension [GlassSegmentedControl.Tab] {
    var snapPoints: [CGFloat] {
        var snapPoints: [CGFloat] = []
        var x: CGFloat = 0
        for tab in self {
            snapPoints.append(x + tab.viewSize.width / 2)
            x += tab.viewSize.width
        }
        
        return snapPoints
    }
    
    func closestSnapPoint(_ offset: CGFloat)-> CGFloat {
        snapPoints.min {
            abs($0 - offset) < abs($1 - offset)
        } ?? offset
    }
    
    func closestSnapPointIndex(_ offset: CGFloat)-> Int? {
        if let (index, _) = snapPoints.enumerated().min(by: {
            abs($0.element - offset) < abs($1.element - offset)
        }) {
            return index
        }
        
        return nil
    }
}

fileprivate struct CustomScrollTarget: ScrollTargetBehavior {
    @Binding var tabs: [GlassSegmentedControl.Tab]
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let offset = target.rect.origin.x
        target.rect.origin.x = tabs.closestSnapPoint(offset)
    }
    
    func properties(context: PropertiesContext) -> Properties {
        var properties = Properties()
        properties.limitsScrolls = true
        return properties
    }
}

#Preview {
    @Previewable @State var selection: Int = 0
    @Previewable @State var tabs: [GlassSegmentedControl.Tab] = [
        .init(title: "Portrait"),
        .init(title: "Photo"),
        .init(title: "Video"),
        .init(title: "Panorama"),
        .init(title: "Cinematic"),
        .init(title: "Dolby Vision"),
    ]
    
    GlassSegmentedControl(selection: $selection, tabs: $tabs)
        .preferredColorScheme(.dark)
        .task {
            selection = 0
        }
        .onChange(of: selection) { oldValue, newValue in
            print(newValue)
        }
}
  
