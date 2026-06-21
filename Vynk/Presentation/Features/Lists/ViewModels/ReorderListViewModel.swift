//
//  ReorderListViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/06/26.
//

import Foundation
import VynkLifecycleMacros
import SwiftUI

@LifecycleLogged
@MainActor
@Observable
final class ReorderListViewModel {
    var lists: [ChatListRowModel] = []
    var availablePresets: [ChatListRowModel] = []
    var alertConfig: DialogConfig?
    private var observeListsTask: Task<Void, Never>?
    private var observePresetsTask: Task<Void, Never>?
    
    private let observeVisibleListsUseCase: ObserveVisibleListsUseCase
    private let observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase
    private let deleteChatListUseCase: DeleteChatListUseCase
    private let restorePresetUseCase: RestorePresetListUseCase
    
    init(
        observeVisibleListsUseCase: ObserveVisibleListsUseCase,
        observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase,
        deleteChatListUseCase: DeleteChatListUseCase,
        restorePresetUseCase: RestorePresetListUseCase,
    ) {
        self.observeVisibleListsUseCase = observeVisibleListsUseCase
        self.observeAvailablePresetsUseCase = observeAvailablePresetsUseCase
        self.deleteChatListUseCase = deleteChatListUseCase
        self.restorePresetUseCase = restorePresetUseCase
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
                AppLogger.error(error.localizedDescription, tag: String(describing: self))
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

        switch list.kind {

        case .custom:
            alertConfig = .init(title: "Delete \(list.title)", message: "Your chats with people and groups will not be deleted.", actions: [
                .init(title: "Delete", role: .destructive){[weak self] in
                    guard let self else { return }
                    Task {
                        await self.deleteCustomList(model: list)
                    }
                }
            ])

        case .unread, .groups, .communities:
            alertConfig = .init(title: "Delete \(list.title)", message: "Deleting this preset list will hide it from view. Your chats with people and groups won't be deleted. To add this list again, go to Lists in Settings.", actions: [
                .init(title: "Delete", role: .destructive){[weak self] in
                    guard let self else { return }
                    Task {
                        await self.deleteCustomList(model: list)
                    }
                }
            ])

        case .favorites:
            return
        }
    }
    
    func deleteCustomList(model: ChatListRowModel) async{
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
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
}
