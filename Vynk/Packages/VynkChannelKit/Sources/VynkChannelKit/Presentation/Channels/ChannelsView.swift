//
//  SwiftUIView.swift
//  VynkChannelKit
//
//  Created by Vijay Thakur on 16/07/26.
//

import SwiftUI
import VynkDesignSystem
import ComposableArchitecture

public struct ChannelsView: View {
    let store: StoreOf<ChannelsFeature>
    
    public init(store: StoreOf<ChannelsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: AppSpacing.xs){
            header
            list
            actions
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
            ForEach(
                store.scope(
                    state: \.channels,
                    action: \.channels
                )
            ) { store in
                ChannelRowView(store: store)
            }
        }
    }
    
    @ViewBuilder
    func actionButton(icon: String, label: String, action: ()->())-> some View {
        HStack(spacing: AppSpacing.md){
            Image(systemName: icon)
            Text(label)
        }
        .font(AppFont.bodySemibold)
        .foregroundStyle(AppColors.contentDefault)
        .fillWidth()
        .padding(.vertical)
        .background(AppColors.backgroundSecondary, in: .capsule)
    }
    
    var actions: some View {
        VStack(spacing: AppSpacing.md){
            actionButton(icon: AppSymbols.grid.name, label: "Explore more") {
                
            }
            
            actionButton(icon: AppSymbols.plus.name, label: "Create channel") {
                
            }
        }
        .padding()

    }
}
