//
//  ListsViewModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 12/06/26.
//

import Foundation
import VynkLifecycleMacros

@LifecycleLogged
@MainActor
@Observable
final class ListsViewModel {
    
    var lists: [ChatListRowModel] = []
    var availablePresets: [ChatListRowModel] = []
    private var observeListsTask: Task<Void, Never>?
    private var observePresetsTask: Task<Void, Never>?
    
    private let observeVisibleListsUseCase: ObserveVisibleListsUseCase
    private let observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase
    private let restorePresetListUseCase: RestorePresetListUseCase
    
    init(
        observeVisibleListsUseCase: ObserveVisibleListsUseCase,
        observeAvailablePresetsUseCase: ObserveAvailablePresetsUseCase,
        restorePresetListUseCase: RestorePresetListUseCase,
    ) {
        self.observeVisibleListsUseCase = observeVisibleListsUseCase
        self.observeAvailablePresetsUseCase = observeAvailablePresetsUseCase
        self.restorePresetListUseCase = restorePresetListUseCase
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
    
    var isCustomListsEmpty: Bool {
        lists.first { $0.kind == ChatListKind.custom } == nil
    }
    
    func restorePreset(id: String)async {
        do {
            try await restorePresetListUseCase.execute(id: id)
        }catch {
            AppLogger.error(error.localizedDescription, tag: String(describing: self))
        }
    }
}
