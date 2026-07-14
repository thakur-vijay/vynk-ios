//
//  SectionRowView.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 13/07/26.
//

import SwiftUI

public struct SectionRowView<ID: Hashable>: View {
    let row: SectionRowModel<ID>
    let binding: Binding<Bool>?
    var selection: ID?
    let action: ()->()
    
    public init(row: SectionRowModel<ID>, binding: Binding<Bool>?, selection: ID? = nil, action: @escaping () -> Void) {
        self.row = row
        self.binding = binding
        self.selection = selection
        self.action = action
    }
    
    public var body: some View {
        if row.kind == .toggle {
            HStack(spacing: AppSpacing.md) {
                if let icon = row.symbol {
                    Image(systemName: icon)
                }
                Toggle(row.title, isOn: binding ?? .constant(false))
            }
        }else {
            Button(action: action) {
                NavigationLink {
                    
                } label: {
                    HStack(spacing: AppSpacing.md) {
                        if let icon = row.symbol {
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
