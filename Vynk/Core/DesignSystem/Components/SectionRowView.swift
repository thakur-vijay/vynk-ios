//
//  SectionRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

struct SectionRowView<ID: RowIDProtocol>: View {
    let row: SectionRowModel<ID>
    let toggleBinding: Binding<Bool>?
    var selection: ID?
    let action: ()->()
    var body: some View {
        if row.kind == .toggle {
            HStack(spacing: AppSpacing.md) {
                if let icon = row.id.symbol {
                    Image(systemName: icon)
                }
                Toggle(row.title, isOn: toggleBinding ?? .constant(false))
            }
        }else {
            Button(action: action) {
                NavigationLink {
                    
                } label: {
                    HStack(spacing: AppSpacing.md) {
                        if let icon = row.id.symbol {
                            Image(systemName: icon)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(row.title)
                                .foregroundStyle(titleColor)
                            if let subtitle = row.subtitle {
                                Text(subtitle)
                                    .font(AppFont.caption)
                                    .foregroundStyle(AppColors.contentDeemphasized)
                            }
                        }
                        .fillWidth(.leading)
                        
                        if let trailingText = row.trailingText {
                            Text(trailingText)
                                .foregroundStyle(AppColors.contentDeemphasized)
                        }
                        
                        if let selection, selection == row.id {
                            AppSymbols.checkmark.image
                                .foregroundStyle(AppColors.accent)
                        }
                    }
                }
                .allowsHitTesting(false)
                .navigationLinkIndicatorVisibility(row.showsChevron ? .visible : .hidden)
            }
            .tint(.primary)
        }
      
    }
    
    private var titleColor: Color {
        switch row.kind {
        case .destructive:
            return .red
        case .action(let style):
            switch style {
            case .normal:
                return .primary
            case .accent:
                return AppColors.accent
            }
        default:
            return .primary
        }
    }
}
