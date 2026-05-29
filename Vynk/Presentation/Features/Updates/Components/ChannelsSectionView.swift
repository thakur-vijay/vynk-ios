//
//  ChannelsSectionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 29/05/26.
//

import SwiftUI

struct ChannelsSectionView: View {
    var body: some View {
        VStack(spacing: AppSpacing.xs){
            header
            list
        }
    }
    
    var header: some View {
        HStack {
            Text("Channels")
                .font(AppFont.title3)
            Spacer(minLength: 0)
            Button {
                
            } label: {
                Text("Explore")
                    .font(AppFont.subheadline)
                    .padding(.horizontal, AppSpacing.md)
                    .padding(.vertical, AppSpacing.sm)
                    .background(AppColors.backgroundSecondary, in: .capsule)
            }
            .tint(AppColors.contentDefault)

        }
        .padding(.horizontal)
    }
    
    var list: some View {
        LazyVStack {
            ForEach(MessageThreadRowModel.sampleList) { channel in
                MessageThreadRowView(model: channel)
            }
        }
    }
}

#Preview {
    ChannelsSectionView()
}

struct ScrollViewSwipeActionsModifier: ViewModifier {
    @State private var size: CGSize = .init(width: 1, height: 1)
    func body(content: Content) -> some View {
        List {
            LazyVStack {
                content
            }
            .onGeometryChange(for: CGSize.self) {
                $0.size
            } action: { newValue in
                print(newValue)
                size = newValue
            }
            .listRowInsets(.init())
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)

        }
        .scrollDisabled(true)
        .listStyle(.plain)
        .frame(height: size.height)
        .contentMargins(.vertical, .init(), for: .scrollContent)
    }
}

extension View {
    func enableScrollViewSwipeActions()-> some View {
        self
            .modifier(ScrollViewSwipeActionsModifier())
    }
}

