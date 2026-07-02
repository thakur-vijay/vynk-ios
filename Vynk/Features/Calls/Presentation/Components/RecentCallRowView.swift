//
//  RecentCallRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import SwiftUI

struct RecentCallRowView: View {
    let model: CallRowModel
    var body: some View {
        HStack(spacing: AppSpacing.md){
            VynkRemoteImage(
                url: .init(
                    string: model.avatarURL ?? ""
                ),
                width: AppAvatarSize.md,
                height: AppAvatarSize.md,
                shape: .circle
            )
            
            VStack(alignment: .leading, spacing: AppSpacing.xxxs) {
                Text(model.name)
                    .font(AppFont.subheadline)
                    .fillWidth(.leading)
                    .foregroundStyle(model.type.color)
                HStack(spacing:AppSpacing.xs){
                    model.statusSymbol
                    Text(model.type.rawValue)
                }
                .font(AppFont.caption)
                .foregroundStyle(AppColors.contentDeemphasized)
            }
            .fillWidth(.leading)
            Text(model.timestamp)
                .font(AppFont.subheadline)
                .foregroundStyle(AppColors.contentDeemphasized)
            AppSymbols.info.image
        }
        .padding(.horizontal)
        .padding(.vertical, AppSpacing.md)
        .swipeActions(edge: .trailing) {
            swipeButton(AppSymbols.trash.name, tint: AppColors.statusDanger) {
                
            }
            
            swipeButton("ellipsis", tint: AppColors.neutralMuted) {
                
            }
        }
        .contextMenu {
            Button {
                
            } label: {
                Label("Voice call", systemImage: AppSymbols.phone.name)
            }
            
            Button {
                
            } label: {
                Label("Video call", systemImage: AppSymbols.video.name)
            }
            
            Menu {
                Button {
                    
                } label: {
                    Label("Add to Favourites", systemImage: AppSymbols.heart.name)
                }
                
                Button {
                    
                } label: {
                    Label("Block Vijay", systemImage: AppSymbols.nosign.name)
                }
                
                Button(role: .destructive){
                    
                } label: {
                    Label("Delete call", systemImage: AppSymbols.trash.name)
                }
            } label: {
                Label("More", systemImage: AppSymbols.ellipsisCircle.name)
            }
           
            
        }
    }
    
    @ViewBuilder
    func swipeButton(_ icon: String, tint: Color, action: ()->())-> some View {
        Button {
            
        } label: {
            VStack {
                Image(systemName: icon)
            }
        }
        .tint(tint)
        
    }
}

