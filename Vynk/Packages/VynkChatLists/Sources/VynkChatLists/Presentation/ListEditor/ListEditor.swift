//
//  CreateNewListView.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import SwiftUI
import VynkDesignSystem
import ComposableArchitecture

@available(iOS 17.0, *)
struct ListEditor: View {
    @Bindable var store: StoreOf<ListEditorFeature>
    
    init(store: StoreOf<ListEditorFeature>) {
        self.store = store
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        TextField("", text: $store.title, prompt: listNamePrompt)
                    }
                } header: {
                    Text("List name")
                } footer: {
                    Text("Any list you create becomes a filter at the top of your Chats tab.")
                }

            }
            .navigationTitle(store.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarCloseButton(placement: .topBarLeading){
                    
                }
                
                CheckButton(isEnabled: store.isSaveEnabled) {
                    store.send(.saveButtonTapped)
                }
            }
        }
    }
    
    var listNamePrompt: Text {
        Text("Examples: Work, Friends")
            .font(AppFont.body)
            .foregroundStyle(AppColors.contentDeemphasized)
    }
}
