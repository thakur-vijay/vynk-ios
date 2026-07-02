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
            ForEach(MockDataFactory.chats.prefix(3)) { channel in
                MessageThreadRowView(model: channel)
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
        .hSpacing()
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
