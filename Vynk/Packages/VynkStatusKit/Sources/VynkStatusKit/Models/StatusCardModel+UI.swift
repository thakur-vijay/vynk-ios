//
//  SwiftUIView.swift
//  VynkStatusKit
//
//  Created by Vijay Thakur on 15/07/26.
//

import Foundation
import VynkDesignSystem
import SwiftUI

public extension StatusCardModel {

    var hasStatus: Bool {
        !statuses.isEmpty
    }

    var title: String {
        isCurrentUser
            ? (hasStatus ? "My Status" : "Add Status")
            : user.name
    }

    var avatarURL: URL? {
        URL(string: user.avatarURL)
    }

    var previewURL: URL? {
        guard let url = statuses.last?.mediaURL else {
            return nil
        }

        return URL(string: url)
    }

    /// Business rule
    var showsAddButton: Bool {
        isCurrentUser
    }

    /// Business rule
    var showsPlaceholderBorder: Bool {
        isCurrentUser && !hasStatus
    }

    var avatarSize: CGFloat {
        showsPlaceholderBorder
            ? AppAvatarSize.xl
            : AppAvatarSize.lg
    }

    var imageSize: CGFloat {
        showsPlaceholderBorder
            ? AppAvatarSize.xl
            : AppAvatarSize.lg - 7
    }

    var titleColor: Color {
        hasStatus
            ? AppColors.white
            : AppColors.contentDefault
    }

    var titleAlignment: HorizontalAlignment {
        hasStatus
            ? .leading
            : .center
    }

    var titleFrameAlignment: Alignment {
        hasStatus
            ? .leading
            : .center
    }

    var topPadding: CGFloat {
        showsPlaceholderBorder
            ? AppSpacing.lg
            : 0
    }

    var avatarBorderColor: Color {

        guard hasStatus else {
            return .clear
        }

        // Later
        // return isSeen ? gray : green

        return AppColors.accentLight
    }
}
