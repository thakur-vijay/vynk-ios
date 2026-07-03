//
//  PrivacyAppLockViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation
import SwiftUI
import VynkSecurity

extension AppLockOption: RowIDProtocol {
    var symbol: String? {
        nil
    }
}

@MainActor
@Observable
final class PrivacyAppLockViewModel {
    
    private(set) var isFaceIDRequired: Bool = false
    
    var action: SectionModel<AppLockAction> = .init(
        footer: "When enabled, you'll need to use Face ID to unlock Vynk. You can still reply to messages from notifications and answer calls if Vynk is locked.",
        rows: [
            .init(id: .requireFaceID, title: "Require Face ID", kind: .toggle)
        ]
    )
    
    var appLockOptions: SectionModel<AppLockOption> = .init(rows: [
        .init(id: .immediately, title: "Immediately", kind: .action(style: .normal), showsChevron: false),
        .init(id: .afterOneMinute, title: "After 1 minute", kind: .action(style: .normal), showsChevron: false),
        .init(id: .afterFifteenMinutes, title: "After 15 minutes", kind: .action(style: .normal), showsChevron: false),
        .init(id: .afterOneHour, title: "After 1 hour", kind: .action(style: .normal), showsChevron: false),
    ])
    
    private(set) var selectedOption: AppLockOption? = .immediately
    
    private let appLockManager: AppLockManager
    
    init(appLockManager: AppLockManager) {
        self.appLockManager = appLockManager
        self.isFaceIDRequired = appLockManager.isEnabled
        self.selectedOption = appLockManager.lockOption
    }
    
    func setFaceIDRequired(_ value: Bool) {
        isFaceIDRequired = value
        appLockManager.setEnabled(value)
    }
    
    func selectOption(_ option: AppLockOption) {
        selectedOption = option
        appLockManager.setLockOption(option)
    }
}
