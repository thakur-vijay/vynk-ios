//
//  ListsFeatureTests.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 06/07/26.
//


import Testing
import ComposableArchitecture

@testable import VynkChatLists

@MainActor
struct ListsFeatureTests {
    @Test
    func createListButtonTappedPresentsListEditor() async {
        let store = TestStore(
            initialState: ListsFeature.State()
        ) {
            ListsFeature()
        }
        
        await store.send(.createListButtonTapped) { state in
            state.destination = .listEditor(
                ListEditorFeature.State(mode: .create)
            )
        }
    }
    
    @Test
    func reorderButtonTappedPresentsReorderLists() async {
        let store = TestStore(initialState: ListsFeature.State()) {
            ListsFeature()
        }
        
        await store.send(.reorderButtonTapped) { state in
            state.destination = .reorderLists(
                ReorderListsFeature.State()
            )
        }
    }
    
    @Test
    func restorePresetTappedCallsClient() async {
        let receivedID = LockIsolated<String?>(nil)
        let store = TestStore(initialState: ListsFeature.State()) {
            ListsFeature()
        } withDependencies: {
            $0.chatListsClient.restorePreset = { id in
                receivedID.setValue(id)
            }
        }

        await store.send(.restorePresetTapped("preset-123"))
        
        #expect(receivedID.value == "preset-123")
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
        let continuation = LockIsolated<
            AsyncThrowingStream<[ChatList], Error>.Continuation?
        >(nil)

        let stream = AsyncThrowingStream<[ChatList], Error> { c in
            continuation.setValue(c)
        }
        
        let store = TestStore(initialState: ListsFeature.State()) {
            ListsFeature()
        } withDependencies: {
            $0.chatListsClient.observeVisibleLists = {
                stream
            }
        }

        _ = await store.send(.onTask)
        
        continuation.withValue { continuation in
            continuation?.yield([chatList])
            continuation?.finish()
        }
        
        await store.receive(
            {
                if case .visibleListsResponse = $0 {
                    return true
                }
                return false
            }
        ) {
            $0.lists = [
                ChatListRowModel(chatList)
            ]
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
        let stream = AsyncThrowingStream<[ChatList], Error> { c in
            continuation.setValue(c)
        }
        let store = TestStore(initialState: ListsFeature.State()) {
            ListsFeature()
        } withDependencies: {
            $0.chatListsClient.observeAvailablePresets = { stream }
        }

        _ = await store.send(.onTask)
        continuation.withValue { continuation in
            continuation?.yield([chatList])
            continuation?.finish()
        }
        await store.receive({ action in
            if case .availablePresetsResponse = action {
                return true
            }
            return false
        }) { state in
            state.availablePresets = [ChatListRowModel(chatList)]
        }
    }
    
    @Test
    func onDisappearCancelsObservations() async {
        let continuation = LockIsolated<AsyncThrowingStream<[ChatList], Error>.Continuation?>(nil)
        let visibleListsStream = AsyncThrowingStream<[ChatList], Error>{ c in
            continuation.setValue(c)
        }
        let availablePresetStream = AsyncThrowingStream<[ChatList], Error>{ c in
            continuation.setValue(c)
        }
        let store = TestStore(initialState: ListsFeature.State()) {
            ListsFeature()
        } withDependencies: {
            $0.chatListsClient.observeVisibleLists = { visibleListsStream }
            $0.chatListsClient.observeAvailablePresets = { availablePresetStream }
        }
        
        await store.send(.onTask)
        await store.send(.onDisappear)
        await store.finish()
    }
    
    @Test
    func visibleListsResponseUpdatesLists() async {
        let chatList = ChatList(
            id: "1",
            kind: .custom,
            title: "Friends",
            sortOrder: 0,
            isVisible: true,
            createdAt: .now,
            updatedAt: .now
        )
        
        let store = TestStore(initialState: ListsFeature.State()) {
            ListsFeature()
        }
        await store.send(.visibleListsResponse([chatList])) {
            $0.lists = [ChatListRowModel(chatList)]
        }
    }
    
    @Test
    func availablePresetsResponseUpdatesAvailablePresets() async {
        let chatList = ChatList(
            id: "1",
            kind: .custom,
            title: "Friends",
            sortOrder: 0,
            isVisible: true,
            createdAt: .now,
            updatedAt: .now
        )
        
        let store = TestStore(initialState: ListsFeature.State()) {
            ListsFeature()
        }
        
        await store.send(.availablePresetsResponse([chatList])) { state in
            state.availablePresets = [ChatListRowModel(chatList)]
        }
    }
    
    @Test
    func destinationSaveCompletedDismissesListEditor() async {
        var state = ListsFeature.State()
        state.destination = .listEditor(
            ListEditorFeature.State(mode: .create)
        )

        let store = TestStore(
            initialState: state
        ) {
            ListsFeature()
        }
        
        await store.send(.destination(.presented(.listEditor(.saveCompleted)))) { state in
            state.destination = nil
        }
    }
}
