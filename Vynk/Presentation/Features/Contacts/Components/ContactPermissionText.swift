//
//  ContactPermissionText.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import SwiftUI

struct ContactPermissionText: View {
    var body: some View {
        RichTextView(message: "Some names may not appear because Vynk doesn't have full contact access. Allow access", metadata: [
            "Allow access": "/settings"
        ], attributionColor: AppColors.accentSoft) { _ in
            AppSettingsOpener.open()
        }
        .font(AppFont.body)
        .hSpacing()
        .clearListRowStyle()
    }
}

#Preview {
    ContactPermissionText()
}
