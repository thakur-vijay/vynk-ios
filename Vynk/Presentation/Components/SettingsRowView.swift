//
//  SettingsRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 27/05/26.
//

import SwiftUI

struct SettingsRow<ID: Hashable, Leading: View, Trailing: View>: View {
    let model: SettingsRowModel<ID>
    let showDivider: Bool
    @ViewBuilder var leading: Leading
    @ViewBuilder var trailing: Trailing
    let onTap: (() -> Void)?
    
    var body: some View {
        if let onTap, model.isTapEnabled {

            Button(action: onTap) {
                rowContent
            }
            .buttonStyle(.row)

        } else {

            rowContent

        }
    }

    private var rowContent: some View {

        HStack(spacing: AppSpacing.md) {
            leading
                .frame(width: 28)
            VStack(spacing: 0) {
                HStack(spacing: AppSpacing.sm) {
                    VStack(
                        alignment: .leading,
                        spacing: AppSpacing.xxs
                    ) {
                        Text(model.title)
                            .foregroundStyle(titleColor)
                            .multilineTextAlignment(.leading)
                        
                        if let subtitle = model.subtitle {
                            Text(subtitle)
                                .font(AppFont.footnote)
                                .foregroundStyle(AppColors.contentDeemphasized)
                                .multilineTextAlignment(.leading)
                        }
                        
                    }
                    
                    Spacer(minLength: AppSpacing.sm)
                    if let trailingText = model.trailingText {
                        Text(trailingText)
                            .foregroundStyle(AppColors.contentDeemphasized)
                    }
                    trailing
                    if model.showsChevron {
                        Image(systemName: "chevron.right")
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(AppColors.contentDeemphasized)
                    }
                }
                
                
            }
            .padding(.vertical, AppSpacing.md)
            .overlay(alignment: .bottom) {
                if showDivider {
                    Divider()
                }
            }
            
        }
        .padding(.horizontal, AppSpacing.lg)
        .contentShape(.rect)

    }

    private var dividerLeadingPadding: CGFloat {

        AppSpacing.lg + 28 + AppSpacing.md

    }
    
    private var titleColor: Color {
        switch model.kind {
        case .destructive:
            return .red
        case .action(let style):
            switch style {
            case .normal:
                return AppColors.contentDefault
            case .accent:
                return AppColors.accent
            }
        default:
            return AppColors.contentDefault
        }
    }
}

extension SettingsRow where Trailing == EmptyView {
    
    init(
        model: SettingsRowModel<ID>,
        showDivider: Bool,
        onTap: (()->())? = nil,
        @ViewBuilder leading: () -> Leading
    ) {
        self.init(
            model: model,
            showDivider: showDivider,
            leading: leading,
            trailing: { EmptyView() },
            onTap: onTap
        )
    }
}

extension ButtonStyle where Self == RowPressStyle {
    static var row: Self {
        return RowPressStyle()
    }
}

struct RowPressStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {

        configuration.label
            .background(
                configuration.isPressed
                ? AppColors.neutralSubtle
                : Color.clear, in: .rect(cornerRadius: 0, style: .continuous)
            )

    }

}
