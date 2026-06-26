//
//  ModeSliderView.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import SwiftUI

struct ModeSliderItem<Mode: Hashable>: Identifiable, Hashable {
    let id: Mode
    let title: String

}

struct ModeSliderView<Mode: Hashable>: View {
    var modes: [ModeSliderItem<Mode>]
    @Binding var selection: Mode?
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(modes) { mode in
                        Text(mode.title)
                            .foregroundStyle(selection == mode.id ? .yellow : .white)
                            .id(mode.id)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, size.width / 2)
                .padding(.vertical, 10)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $selection, anchor: .center)
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
        }
        .frame(height: 50)
        .background(.red)
    }
}
