//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem
import VynkCountryPicker

struct PhoneNumberView: View {

    @Bindable var store: StoreOf<PhoneNumberFeature>
    
    init(store: StoreOf<PhoneNumberFeature>) {
        self.store = store
    }

    @FocusState
    private var isPhoneFocused: Bool

    var body: some View {

        List {
            Text("Enter your phone number")
                .font(AppFont.title2.bold())
                .clearListRowStyle()
                .fillWidth()
                .multilineTextAlignment(.center)

            Text("Vynk will need to verify your account. Carrier charges may apply.")
                .clearListRowStyle()
                .font(AppFont.subheadline)
                .foregroundStyle(AppColors.contentDeemphasized)
                .fillWidth()
                .multilineTextAlignment(.center)
            phoneNumberAndCountryPickerView
        }
        .scrollContentBackground(.hidden)
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            VStack {
                AppButton(
                    text: "Next",
                    foreground: store.isActionEnabled
                        ? AppColors.white
                        : AppColors.contentDeemphasized,
                    background: store.isActionEnabled
                        ? AppColors.accent
                        : AppColors.gray.opacity(0.15)
                ) {
                    store.send(.nextButtonTapped)
                }
                .disabled(!store.isActionEnabled)
            }
            .padding(.horizontal, AppSpacing.lg)
            .padding(.vertical, AppSpacing.md)
            .background(.background)
        }
        .sheet(
            item: $store.scope(
                state: \.destination,
                action: \.destination
            )
        ) { destinationStore in
            switch destinationStore.state {
            case .countryPicker:
                if let store = destinationStore.scope(
                    \.countryPicker,
                    action: \.countryPicker
                ) {
                    CountryPickerView(store: store)
                }
            }
        }
        .task {
            isPhoneFocused = true
            await store.send(.onTask).finish()
        }
    }
    
    var phoneNumberAndCountryPickerView: some View {
        Section {
            Button {
                store.send(.countryPickerTapped)
            } label: {
                NavigationLink {
                    
                } label: {
                    Text(store.selectedCountry?.name ?? "")
                        .foregroundStyle(AppColors.accentEmphasized)
                        .fillWidth(.leading)
                }
                .allowsHitTesting(false)

            }
            .listRowBackground(AppColors.gray.opacity(0.1))
            
            HStack {
                Text(store.selectedCountry?.dialCode ?? "")
                    .foregroundStyle(AppColors.contentDefault)
                TextField(
                    "",
                    text: $store.phoneNumber,
                    prompt: Text(
                        "your phone number"
                    )
                    .foregroundStyle(AppColors.contentDeemphasized)
                )
                .focused($isPhoneFocused)
                .keyboardType(.numberPad)
                .textContentType(.telephoneNumber)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .tint(AppColors.accentEmphasized)

            }
            .listRowBackground(AppColors.gray.opacity(0.1))
        }
        .font(AppFont.subheadline)
    }
    
    
}
