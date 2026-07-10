//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

struct PhoneNumberView: View {
    let store: StoreOf<PhoneNumberFeature>
    
    init(store: StoreOf<PhoneNumberFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: AppSpacing.lg){
            Text("Enter your phone number")
                .font(AppFont.title2.bold())
            Text("WhatsApp will need to verify your account. Carrier charges may apply.")
                .font(AppFont.caption)
                .foregroundStyle(AppColors.contentDeemphasized)
        }
    }
}
