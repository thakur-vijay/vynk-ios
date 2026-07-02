//
//  ContactPermissionText.swift
//  Vynk
//
//  Created by Vijay Thakur on 04/06/26.
//

import SwiftUI
import VynkFoundation

struct ContactPermissionText: View {
    var body: some View {
        RichTextView(
            configuration: .init(
                text: "Some names may not appear because Vynk doesn't have full contact access. Allow access",
                links: [
                    .init(
                        text: "Allow access",
                        link: "/settings"
                    )
                ],
                linkColor: AppColors.accentSoft
            )) { _ in
                AppSettings.open()
            }
            .font(AppFont.body)
            .fillWidth()
            .clearListRowStyle()
    }
}

#Preview {
    ContactPermissionText()
}
