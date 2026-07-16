//
//  StatusCardView.swift
//  VynkStatusKit
//
//  Created by Vijay Thakur on 15/07/26.
//

import SwiftUI
import VynkDesignSystem
import VynkImage

struct StatusCardView: View {

    let model: StatusCardModel
    let action: () -> Void

    var body: some View {

        RoundedRectangle(cornerRadius: AppRadius.lg)
            .fill(AppColors.backgroundSecondary)
            .frame(statusCardSize)

            .overlay {

                if let previewURL = model.previewURL {

                    RemoteImage(
                        url: previewURL,
                        size: statusCardSize,
                        shape: .rect(
                            cornerRadius: AppRadius.lg,
                            style: .continuous
                        )
                    )
                }
            }

            .overlay {

                if model.hasStatus {

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

                if model.showsPlaceholderBorder {

                    RoundedRectangle(cornerRadius: AppRadius.lg)
                        .stroke(
                            AppColors.linesOutlineDeemphasized,
                            lineWidth: 1
                        )
                }
            }

            .clipShape(
                .rect(
                    cornerRadius: AppRadius.lg,
                    style: .continuous
                )
            )

            .overlay {

                VStack(
                    alignment: model.titleAlignment
                ) {

                    avatarView

                    Spacer()

                    Text(model.title)
                        .font(AppFont.captionSemibold)
                        .foregroundStyle(model.titleColor)
                        .fillWidth(model.titleFrameAlignment)
                }
                .padding(AppSpacing.md)
                .padding(.top, model.topPadding)
            }

            .contentShape(
                .contextMenuPreview,
                .rect(
                    cornerRadius: AppRadius.lg,
                    style: .continuous
                )
            )

            .contentShape(.rect)

            .onTapGesture(perform: action)
    }

    private var avatarView: some View {

        Circle()
            .stroke(
                model.avatarBorderColor,
                lineWidth: 2.5
            )
            .frame(
                width: model.avatarSize,
                height: model.avatarSize
            )

            .overlay {

                if let avatarURL = model.avatarURL {

                    RemoteImage(
                        url: avatarURL,
                        size: .init(
                            width: model.imageSize,
                            height: model.imageSize
                        ),
                        shape: .circle
                    )
                }
            }

            .overlay(alignment: .bottomTrailing) {

                if model.showsAddButton {

                    addButton
                }
            }
    }

    private var addButton: some View {

        Circle()
            .fill(AppColors.white)
            .frame(width: 22, height: 22)
            .overlay {

                AppSymbols.plus.image
                    .font(AppFont.caption)
                    .foregroundStyle(AppColors.white)
                    .frame(width: 17, height: 17)
                    .background(
                        AppColors.accent,
                        in: .circle
                    )
            }
    }

    private let statusCardSize = CGSize(
        width: 112,
        height: 184
    )
}
