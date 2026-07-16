//
//  StatusesView.swift
//  VynkStatusKit
//
//  Created by Vijay Thakur on 15/07/26.
//


import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

public struct StatusesView: View {

    @Bindable var store: StoreOf<StatusesFeature>

    public init(store: StoreOf<StatusesFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: AppSpacing.lg) {
            header
            statusList
        }
    }

    private var header: some View {
        HStack {
            Text("Status")
                .font(AppFont.title3)

            Spacer(minLength: 0)

            actionButton(AppSymbols.camera.name) {
                store.send(.cameraTapped)
            }

            actionButton(AppSymbols.pencil.name) {
                store.send(.pencilTapped)
            }
        }
        .padding(.horizontal)
    }

    private var statusList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 6) {

                StatusCardView(
                    model: store.currentUserStatus
                ) {
                    store.send(.currentUserStatusTapped)
                }

                ForEach(store.statuses) { status in

                    StatusCardView(
                        model: status
                    ) {
                        store.send(.statusTapped(id: status.id))
                    }
                }
            }
            .padding(.horizontal)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .task {
            print("StatusCount", store.statuses.count)
        }
    }

    @ViewBuilder
    private func actionButton(
        _ icon: String,
        action: @escaping () -> Void
    ) -> some View {

        Button(action: action) {

            Circle()
                .fill(AppColors.backgroundSecondary)
                .frame(width: AppIconSize.xl, height: AppIconSize.xl)
                .overlay {
                    Image(systemName: icon)
                        .font(AppFont.captionSemibold)
                }
        }
    }
}
