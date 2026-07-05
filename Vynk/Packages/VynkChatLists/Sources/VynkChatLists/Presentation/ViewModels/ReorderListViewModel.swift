//
//  ReorderListViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import SwiftUI
import VynkDesignSystem
import VynkFoundation

@available(iOS 17.0, *)
@MainActor
@Observable
final class ReorderListViewModel {
    var lists: [ChatListRowModel] = []
    var availablePresets: [ChatListRowModel] = []
    var alertConfig: DialogConfiguration?
    private var observeListsTask: Task<Void, Never>?
    private var observePresetsTask: Task<Void, Never>?
    
    private let observeVisibleListsUseCase: ObserveVisibleListsUseCase
    private let observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase
    private let deleteChatListUseCase: DeleteChatListUseCase
    private let restorePresetUseCase: RestorePresetListUseCase
    private let reorderChatListsUseCase: ReorderChatListsUseCase
    
    init(
        observeVisibleListsUseCase: ObserveVisibleListsUseCase,
        observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase,
        deleteChatListUseCase: DeleteChatListUseCase,
        restorePresetUseCase: RestorePresetListUseCase,
        reorderChatListsUseCase: ReorderChatListsUseCase,
    ) {
        self.observeVisibleListsUseCase = observeVisibleListsUseCase
        self.observeAvailablePresetsUseCase = observeAvailablePresetsUseCase
        self.deleteChatListUseCase = deleteChatListUseCase
        self.restorePresetUseCase = restorePresetUseCase
        self.reorderChatListsUseCase = reorderChatListsUseCase
    }
    
    private func startObservingVisibleLists() {
        observeListsTask?.cancel()
        
        observeListsTask = Task { [weak self] in
            guard let self else { return }
            
            do {
                for try await result in observeVisibleListsUseCase.execute() {
                    lists = result.map {
                        ChatListMapper.map($0)
                    }
                }
            } catch {
                Log.error(error.localizedDescription, String(describing: self))
            }
        }
    }
    
    private func startObservingAvailablePresets() {

        observePresetsTask?.cancel()

        observePresetsTask = Task { [weak self] in

            guard let self else { return }

            do {

                for try await presets
                in observeAvailablePresetsUseCase.execute() {

                    availablePresets = presets.map {
                        ChatListMapper.map($0)
                    }
                }

            } catch {

            }
        }
    }
    
    func startObserving(){
        startObservingVisibleLists()
        startObservingAvailablePresets()
    }
    
    func stopObserving() {
        observeListsTask?.cancel()
        observePresetsTask?.cancel()
        observeListsTask = nil
        observePresetsTask = nil
    }
    
    func presentDeleteAlert(for list: ChatListRowModel) {
        alertConfig = ChatListAlertFactory.makeDeleteAlert(
            for: list,
            onDelete: {[weak self] in
                guard let self else { return }
                Task {
                    await self.deleteList(model: list)
                }
        })
    }
    
    func deleteList(model: ChatListRowModel) async{
        do {
            try await deleteChatListUseCase.execute(list: model)
            if model.kind == .custom {
                lists.removeAll { $0.id == model.id }
            }else {
                availablePresets.removeAll { $0.id == model.id }
            }
        }catch {
            
        }
    }
    
    func restorePreset(id: String)async {
        do {
            try await restorePresetUseCase.execute(id: id)
        }catch {
            Log.error(error.localizedDescription, String(describing: self))
        }
    }
    
    func move(
        from source: IndexSet,
        to destination: Int
    ) {
        var reorderedLists = lists

        reorderedLists.move(
            fromOffsets: source,
            toOffset: destination
        )

        lists = reorderedLists

        let orderedIds = reorderedLists.map(\.id)

        Task {
            await updateSortOrder(orderedIds: orderedIds)
        }
    }

    private func updateSortOrder(
        orderedIds: [String]
    ) async {
        do {
            try await reorderChatListsUseCase.execute(
                ids: orderedIds
            )
        } catch {
            Log.error(error.localizedDescription, String(describing: self))
        }
    }
}
