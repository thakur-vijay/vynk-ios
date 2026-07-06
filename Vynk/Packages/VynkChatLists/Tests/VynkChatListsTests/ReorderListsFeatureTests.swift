//
//  Test.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 06/07/26.
//

import Testing
import ComposableArchitecture
@testable import VynkChatLists

@MainActor
struct ReorderListsFeatureTests {

    @Test
    func deleteButtonTappedPresentsDeleteAlert() async {
        let model = ChatListRowModel(
            ChatList(
                id: "1",
                kind: .custom,
                title: "Friends",
                sortOrder: 0,
                isVisible: true,
                createdAt: .now,
                updatedAt: .now
            )
        )
        
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        }
        
        await store.send(.deleteButtonTapped(model)) { state in
            state.deletingList = model
            state.alert = .deleteConfirmation
        }
    }

    @Test
    func confirmDeleteCallsClientDelete() async {
        let model = ChatListRowModel(
            ChatList(
                id: "1",
                kind: .custom,
                title: "Friends",
                sortOrder: 0,
                isVisible: true,
                createdAt: .now,
                updatedAt: .now
            )
        )
        let deletedModel = LockIsolated<ChatListRowModel?>(nil)
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        } withDependencies: {
            $0.chatListsClient.delete = { model in
                deletedModel.setValue(model)
            }
        }
        await store.send(.deleteButtonTapped(model)) { state in
            state.deletingList = model
            state.alert = .deleteConfirmation
        }
        await store.send(.alert(.presented(.confirmDelete))) { state in
            state.deletingList = nil
            state.alert = nil
        }
        
        #expect(deletedModel.value == model)
    }
    
    @Test
    func moveUpdatesStateAndCallsClient() async {
        let models: [ChatListRowModel] = [
            .init(id: "1", title: "Friends", kind: .custom, canDelete: true, canEdit: true, order: 1, isSelected: false),
            .init(id: "2", title: "Family", kind: .custom, canDelete: true, canEdit: true, order: 2, isSelected: false),
            .init(id: "3", title: "Work", kind: .custom, canDelete: true, canEdit: true, order: 3, isSelected: false),
        ]
        let receivedIDs = LockIsolated<[String]?>(nil)
        
        var state = ReorderListsFeature.State()
        state.lists = models
        let store = TestStore(initialState: state) {
            ReorderListsFeature()
        } withDependencies: {
            $0.chatListsClient.reorder = { ids in
                receivedIDs.setValue(ids)
            }
        }
        
        await store.send(.move(.init(integer: 0), 3)) { state in
            state.lists = [

                   models[1],

                   models[2],

                   models[0]

               ]
        }
        
        #expect(receivedIDs.value == [
            "2",
            "3",
            "1"
        ])
    }
    
    @Test
    func closeButtonTappedDismisses() async {
        let didDismiss = LockIsolated(false)
        
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        } withDependencies: {
            $0.dismiss = DismissEffect({
                didDismiss.setValue(true)
            })
        }

        await store.send(.closeButtonTapped)
        #expect(didDismiss.value)
    }
    
    @Test
    func visibleListsResponseUpdatesLists() async {
        let list = ChatList(
            id: "1",
            kind: .custom,
            title: "Friends",
            sortOrder: 0,
            isVisible: true,
            createdAt: .now,
            updatedAt: .now
        )
        
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        }
        
        await store.send(.visibleListsResponse([list])) {
            $0.lists = [ChatListRowModel(list)]
        }
    }
    
    @Test
    func availablePresetsResponseUpdatesAvailablePresets() async {
        let list = ChatList(
            id: "1",
            kind: .custom,
            title: "Friends",
            sortOrder: 0,
            isVisible: true,
            createdAt: .now,
            updatedAt: .now
        )
        
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        }
        
        await store.send(.availablePresetsResponse([list])) { state in
            state.availablePresets = [ChatListRowModel(list)]
        }
    }
    
    @Test
    func restorePresetTappedCallsClient() async {
        let presetID = LockIsolated<String?>(nil)
        
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        } withDependencies: {
            $0.chatListsClient.restorePreset = { id in
                presetID.setValue(id)
            }
        }

        await store.send(.restorePresetTapped("preset-123"))
        #expect(presetID.value == "preset-123")
    }
    
    @Test
    func onTaskReceivesVisibleLists() async {
        let chatList = ChatList(
            id: "1",
            kind: .custom,
            title: "Friends",
            sortOrder: 0,
            isVisible: true,
            createdAt: .now,
            updatedAt: .now
        )
        
        let continuation = LockIsolated<AsyncThrowingStream<[ChatList], Error>.Continuation?>(nil)
        let stream = AsyncThrowingStream<[ChatList], Error>{ c in
            continuation.setValue(c)
        }
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        } withDependencies: {
            $0.chatListsClient.observeVisibleLists = { stream }
        }

        await store.send(.onTask)
        continuation.withValue { continuation in
            continuation?.yield([chatList])
            continuation?.finish()
        }
        
        await store.receive({ action in
            if case .visibleListsResponse = action {
                return true
            }else {
                return false
            }
        }) { state in
            state.lists = [ChatListRowModel(chatList)]
        }
    }
    
    @Test
    func onTaskReceivesAvailablePresets() async {
        let chatList = ChatList(
            id: "1",
            kind: .custom,
            title: "Friends",
            sortOrder: 0,
            isVisible: true,
            createdAt: .now,
            updatedAt: .now
        )
        
        let continuation = LockIsolated<AsyncThrowingStream<[ChatList], Error>.Continuation?>(nil)
        let stream = AsyncThrowingStream<[ChatList], Error>{ c in
            continuation.setValue(c)
        }
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        } withDependencies: {
            $0.chatListsClient.observeAvailablePresets = { stream }
        }
        
        await store.send(.onTask)
        continuation.withValue { continuation in
            continuation?.yield([chatList])
            continuation?.finish()
        }

        await store.receive({ action in
            if case .availablePresetsResponse = action {
              return true
            }else {
                return false
            }
        }) { state in
            state.availablePresets = [
                ChatListRowModel(chatList)
            ]
        }
    }
    
    @Test
    func onDisappearCancelsObservations() async {
        let visibleListsContinuation = LockIsolated<AsyncThrowingStream<[ChatList], Error>.Continuation?>(nil)
        let availablePresetsContinuation = LockIsolated<AsyncThrowingStream<[ChatList], Error>.Continuation?>(nil)
        let visibleListsStream = AsyncThrowingStream<[ChatList], Error> { c in
            visibleListsContinuation.setValue(c)
        }
        let availablePresetsStream = AsyncThrowingStream<[ChatList], Error>{ c in
            availablePresetsContinuation.setValue(c)
        }
        
        let store = TestStore(initialState: ReorderListsFeature.State()) {
            ReorderListsFeature()
        } withDependencies: {
            $0.chatListsClient.observeVisibleLists = { visibleListsStream }
            $0.chatListsClient.observeAvailablePresets = { availablePresetsStream }
        }

        await store.send(.onTask)
        await store.send(.onDisappear)
        await store.finish()
    }
}
