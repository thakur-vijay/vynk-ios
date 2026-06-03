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

}

struct ConfirmationDialogConfig {

    let title: String

    let message: String?

    let actions: [DialogAction]

}
