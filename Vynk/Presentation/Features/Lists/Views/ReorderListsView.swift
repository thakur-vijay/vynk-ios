//
//  ReorderListsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import SwiftUI

struct ReorderListsView: View {
    @State private var viewModel: ReorderListViewModel
    
    init(viewModel: ReorderListViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                EditableListsSection(lists: viewModel.lists) { indexSet, destination in
                    viewModel.move(from: indexSet, to: destination)
                } onDeleteRequest: { model in
                    viewModel.presentDeleteAlert(for: model)
                }

                AvailablePresetsSection(presets: viewModel.availablePresets){ preset in
                    Task {
                        await viewModel.restorePreset(id: preset.id)
                    }
                }
            }
            .environment(\.editMode, .constant(.active))
            .navigationTitle("Reorder lists")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ProminentToolbarButton(icon: AppIcons.checkmark, accent: AppColors.contentDefault) {
                    
                }
            }
        }
        .alert($viewModel.alertConfig)
        .task(viewModel.startObserving)
        .onDisappear(perform: viewModel.stopObserving)
    }
}
