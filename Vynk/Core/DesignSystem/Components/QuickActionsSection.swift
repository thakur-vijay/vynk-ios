//
//  QuickActionsSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct QuickActionsSection<ID: Hashable>: View {
    
    let actions: [QuickActionModel<ID>]
    let onTap: (ID) -> Void
    
    var body: some View {
        Section {
            ForEach(actions) { action in
                Button {
                    onTap(action.id)
                } label: {
                    HStack {
                        Image(systemName: action.symbol)
                            .frame(width: AppAvatarSize.md, height:  AppAvatarSize.md)
                            .foregroundStyle(AppColors.accent)
                        VStack(alignment: .leading) {
                            Text(action.title)
                                .font(AppFont.subheadline)
                            if let subtitle = action.subtitle, subtitle.isNotBlank{
                                Text(subtitle)
                                    .font(AppFont.caption)
                                    .foregroundStyle(AppColors.contentDeemphasized)
                            }
                        }
                    }
                }
                .listRowInsets(.vertical, 0)
                .tint(AppColors.contentDefault)
            }
        }
    }
}
