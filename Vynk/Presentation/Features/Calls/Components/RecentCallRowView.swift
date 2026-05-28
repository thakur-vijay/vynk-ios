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
                width: AppSizes.avatarMD,
                height: AppSizes.avatarMD,
                shape: .circle
            )
            
            VStack(alignment: .leading, spacing: AppSpacing.xxxs) {
                Text(model.name)
                    .font(AppFont.subheadline)
                    .hSpacing(.leading)
                    .foregroundStyle(model.type.color)
                HStack(spacing:AppSpacing.xs){
                    Image(systemName: model.statusSymbol)
                    Text(model.type.rawValue)
                }
                .font(AppFont.caption)
                .foregroundStyle(AppColors.contentDeemphasized)
            }
            .hSpacing(.leading)
            Text(model.timestamp)
                .font(AppFont.subheadline)
                .foregroundStyle(AppColors.contentDeemphasized)
            Image(systemName: AppIcons.info)
        }
        .padding(.horizontal)
        .padding(.vertical, AppSpacing.smd)
        .swipeActions(edge: .trailing) {
            swipeButton(AppIcons.trash, tint: AppColors.statusDanger) {
                
            }
            
            swipeButton("ellipsis", tint: AppColors.neutralMuted) {
                
            }
        }
        .contextMenu {
            Button {
                
            } label: {
                Label("Voice call", systemImage: AppIcons.phone)
            }
            
            Button {
                
            } label: {
                Label("Video call", systemImage: AppIcons.video)
            }
            
            Menu {
                Button {
                    
                } label: {
                    Label("Add to Favourites", systemImage: AppIcons.heart)
                }
                
                Button {
                    
                } label: {
                    Label("Block Vijay", systemImage: AppIcons.nosign)
                }
                
                Button(role: .destructive){
                    
                } label: {
                    Label("Delete call", systemImage: AppIcons.trash)
                }
            } label: {
                Label("More", systemImage: AppIcons.ellipsisCircle)
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

