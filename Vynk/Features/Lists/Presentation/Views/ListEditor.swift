//
//  CreateNewListView.swift
//  Vynk
//
//  Created by Vijay Thakur on 20/06/26.
//

import SwiftUI

struct ListEditor: View {
    @State private var viewModel: ListEditorViewModel
    let onClose: ()->()
    
    init(viewModel: ListEditorViewModel, onClose: @escaping ()->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.onClose = onClose
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        TextField("", text: $viewModel.title, prompt: listNamePrompt)
                    }
                } header: {
                    Text("List name")
                } footer: {
                    Text("Any list you create becomes a filter at the top of your Chats tab.")
                }

            }
            .navigationTitle(viewModel.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarCloseButton(placement: .topBarLeading, onClose: onClose)
                
                CheckButton(isEnabled: viewModel.isEnabled) {
                    Task {
                        await viewModel.saveList(onClose: onClose)
                    }
                }
            }
        }
        .task {
            await viewModel.prepare()
        }
    }
    
    var listNamePrompt: Text {
        Text("Examples: Work, Friends")
            .font(AppFont.body)
            .foregroundStyle(AppColors.contentDeemphasized)
    }
}
