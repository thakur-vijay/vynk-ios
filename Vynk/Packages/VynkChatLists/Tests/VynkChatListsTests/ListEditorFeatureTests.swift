//
//  Test.swift
//  VynkChatLists
//
//  Created by Vijay Thakur on 07/07/26.
//

import Testing
import ComposableArchitecture
@testable import VynkChatLists

@MainActor
struct ListEditorFeatureTests {

    @Test
    func saveButtonTappedCallsClientAndCompletes() async {
        let savedTitle = LockIsolated<String?>(nil)
        var state = ListEditorFeature.State(mode: .create)
        state.title = "Friends"
        let store = TestStore(initialState: state) {
            ListEditorFeature()
        } withDependencies: {
            $0.chatListsClient.save = { title in
                savedTitle.setValue(title)
            }
        }

        await store.send(.saveButtonTapped)
        await store.receive(\.saveCompleted)
        #expect(savedTitle.value == "Friends")
    }
    
    @Test
    func closeButtonTappedDismisses() async throws {
        let isDismissed = LockIsolated(false)
        let store = TestStore(
            initialState: ListEditorFeature.State(
                mode: .create
            )) {
                ListEditorFeature()
            } withDependencies: {
                $0.dismiss = DismissEffect({
                    isDismissed.setValue(true)
                })
            }
        await store.send(.closeButtonTapped)
        #expect(isDismissed.value)
    }
    
    @Test
    func createModeNavigationTitle() {
        let state = ListEditorFeature.State(mode: .create)

        #expect(state.navigationTitle == "New list")
    }
    
    @Test
    func editModeNavigationTitle() {
        let state = ListEditorFeature.State(mode: .edit(id: "testID"))

        #expect(state.navigationTitle == "Edit list")
    }
    
    @Test
    func emptyTitleDisablesSave(){
        var state = ListEditorFeature.State(mode: .create)
        state.title = ""

        #expect(state.isSaveEnabled == false)
    }

    @Test
    func whitespaceTitleDisablesSave(){
        var state = ListEditorFeature.State(mode: .create)
        state.title = "   "
        #expect(state.isSaveEnabled == false)
    }
    
    @Test
    func nonEmptyTitleEnablesSave(){
        var state = ListEditorFeature.State(mode: .create)
        state.title = "Friends"
        #expect(state.isSaveEnabled)
    }
}
