//
//  StatusSectionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 29/05/26.
//

import SwiftUI

struct StatusSectionView: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg){
            header
            statusList
        }
    }
    
    var header: some View {
        HStack {
            Text("Status")
                .font(AppFont.title3)
            Spacer(minLength: 0)
            actionButton(AppIcons.camera) {
                
            }
            
            actionButton(AppIcons.pencil) {
                
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func actionButton(_ icon: String, action: ()->())-> some View {
        Circle()
            .fill(AppColors.backgroundSecondary)
            .frame(width: AppSizes.iconXL, height: AppSizes.iconXL)
            .overlay {
                Image(systemName: icon)
                    .font(AppFont.captionSemibold)
            }
    }
    
    var statusList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 6) {
                StatusCardView(
                    isCurrentUser: true,
                    user: .init(id: UUID().uuidString, name: "Vijay Thakur", avatarURL: MockDataFactory.chats.first?.avatarImage ?? ""),
                    statuses: [
                        .init(
                            id: UUID().uuidString,
                            mediaURL: MockDataFactory.chats[2].avatarImage,
                            type: .image,
                            createdAt: .now
                        )
                    ]
                )
                ForEach(1...10, id: \.self) { _ in
                    StatusCardView(
                        isCurrentUser: false,
                        user: .init(
                            id: UUID().uuidString,
                            name: "Test User",
                            avatarURL: MockDataFactory.chats.last?.avatarImage ?? ""
                        ),
                        statuses: [
                            .init(
                                id: UUID().uuidString,
                                mediaURL: MockDataFactory.chats[2].avatarImage,
                                type: .image,
                                createdAt: .now
                            )
                        ]
                    )
                    .customContextMenu(actions: [
                        UIAction(title: "Hide", image: UIImage(named: AppIcons.hide)){ _ in
                            
                        }
                    ]
                    )
                }
            }
            .padding(.horizontal)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
}

#Preview {
    StatusSectionView()
}
