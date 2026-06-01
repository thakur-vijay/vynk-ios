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
                HStack {
                    Image(systemName: action.symbol)
                        .frame(width: AppSizes.avatarMD, height: AppSizes.avatarMD)
                        .foregroundStyle(AppColors.accent)
                    VStack(alignment: .leading) {
                        Text(action.title)
                            .font(AppFont.subheadline)
                        if let subtitle = action.subtitle, subtitle.isNotEmptyString{
                            Text(subtitle)
                                .font(AppFont.caption)
                                .foregroundStyle(AppColors.contentDeemphasized)
                        }
                    }
                }
                .listRowInsets(.vertical, 0)
//                .contentShape(.rect)
//                .onTapGesture {
//                    onTap(action.id)
//                }
            }
        }
    }
}
