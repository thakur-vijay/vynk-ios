//
//  ConfirmationDialogConfig.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import SwiftUI

struct DialogAction: Identifiable {

    let id = UUID()

    let title: String

    let role: ButtonRole?

    let action: () -> Void
    
    init(title: String, role: ButtonRole? = nil, action: @escaping () -> Void = {}) {
        self.title = title
        self.role = role
        self.action = action
    }

}

struct DialogConfig {

    let title: String

    let message: String?

    let actions: [DialogAction]

}
