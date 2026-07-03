//
//  PrivacyDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import SwiftUI
import VynkSecurity

final class PrivacyDIContainer {
    private let appLockManager: AppLockManager
    
    init(appLockManager: AppLockManager) {
        self.appLockManager = appLockManager
    }
    
    func makePrivacyView()->PrivacyView {
        let viewModel = PrivacyViewModel()
        return PrivacyView(viewModel: viewModel)
    }
    
    func makeAppLockView()-> PrivacyAppLockView {
        let viewModel = PrivacyAppLockViewModel(
            appLockManager: appLockManager
        )
        return PrivacyAppLockView(viewModel: viewModel)
    }
    
    @ViewBuilder
      func makeDestination(
          for id: PrivaceRowID
      ) -> some View {
          switch id {
          case .appLock: makeAppLockView()
          default: Text("test")
          }
      }
}
