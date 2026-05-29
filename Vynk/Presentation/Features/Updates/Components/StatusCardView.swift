//
//  StatusCardView.swift
//  Vynk
//
//  Created by Vijay Thakur on 29/05/26.
//

import SwiftUI

struct StatusCardView: View {
    
    let isCurrentUser: Bool
    let user: StatusUserModel
    let statuses: [StatusItemModel]
    
    var hasStatus: Bool {
        !statuses.isEmpty
    }
    
    var title: String {
        isCurrentUser
        ? (hasStatus ? "My status" : "Add status")
        : user.name
    }
    
    var avatarURL: String? {
        user.avatarURL
    }
    
    var previewURL: String? {
        statuses.last?.mediaURL
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: AppRadius.lg)
            .fill(AppColors.backgroundSecondary)
            .frame(AppSizes.statusCardSize)
            .overlay {
                if let previewURL {
                    VynkRemoteImage(
                        url: .init(string: previewURL),
                        width: AppSizes.statusCardSize.width,
                        height: AppSizes.statusCardSize.height,
                        shape: .rect(cornerRadius: AppRadius.lg, style: .continuous)
                    )
                }
            }
            .overlay {
                if hasStatus {
                    LinearGradient(
                        colors: [
                            .black.opacity(0.65),
                            .clear,
                            .clear,
                            .black.opacity(0.75)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            }
            .overlay {
                if isCurrentUser && !hasStatus {
                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 1)
                }
            }
            .clipShape(.rect(cornerRadius: AppRadius.lg, style: .continuous))
            .overlay {
                VStack(alignment: hasStatus ? .leading : .center) {
                    
                    avatarView
                    
                    Spacer(minLength: 0)
                    
                    Text(title)
                        .font(AppFont.captionSemibold)
                        .foregroundStyle(hasStatus ? AppColors.white : AppColors.contentDefault)
                        .hSpacing(hasStatus ? .leading : .center)
                }
                .padding(AppSpacing.smd)
                .padding(.top, isCurrentUser && !hasStatus ? AppSpacing.lg : 0)
            }
            .contextMenu {
                if !isCurrentUser {
                    Button {
                        
                    } label: {
                        Label("Hide", systemImage: AppIcons.hide)
                    }
                }
            }
            .contentShape(
                .contextMenuPreview,
                .rect(cornerRadius: AppRadius.lg, style: .continuous)
            )
            .contentShape(.rect)
    }
    
    private var avatarView: some View {
        Circle()
            .stroke(hasStatus ? AppColors.accentLight : .clear, lineWidth: 2.5)
            .frame(
                width: isCurrentUser && !hasStatus ? AppSizes.avatarXL : AppSizes.avatarLG,
                height: isCurrentUser && !hasStatus ? AppSizes.avatarXL : AppSizes.avatarLG
            )
            .overlay {
                if let avatarURL{
                    VynkRemoteImage(
                        url: .init(string: avatarURL),
                        width: isCurrentUser && !hasStatus ? AppSizes.avatarXL : AppSizes.avatarLG - 7,
                        height: isCurrentUser && !hasStatus ? AppSizes.avatarXL : AppSizes.avatarLG - 7,
                        shape: .circle
                    )
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if isCurrentUser {
                    Circle()
                        .fill(AppColors.white)
                        .frame(width: 22, height: 22)
                        .overlay {
                            Image(systemName: AppIcons.plus)
                                .font(AppFont.caption)
                                .foregroundStyle(AppColors.white)
                                .frame(width: 17, height: 17)
                                .background(AppColors.accent, in: .circle)
                        }
                }
            }
    }
}
