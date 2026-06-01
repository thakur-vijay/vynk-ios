//
//  NewChatBottomSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct NewChatBottomSheet<Content: View>: View {
    @State private var viewModel: NewChatBottomSheetViewModel
    @State private var router: NewChatRouter
    var content: Content
    let onClose: ()->()
    init(viewModel: NewChatBottomSheetViewModel, router: NewChatRouter, @ViewBuilder content: @escaping ()->Content, onClose: @escaping () -> Void) {
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
        self.content = content()
        self.onClose = onClose
    }
    var body: some View {
        NavigationStack(path: $router.path){
            List {
                QuickActionsSection(actions: viewModel.quickActions) { action in
                    switch action {
                    case .newContact:
                        router.presentSheet(.addContact)
                    case .newGroup:
                        router.push(.newGroup)
                    case .newCommunity:
                        break
                    case .newBroadcast:
                        break
                    }
                }
                .listSectionMargins(.top, 5)
                content
            }
            .background(AppColors.backgroundSecondary)
            .navigationTitle("New chat")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.search, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search name or number"))
            .toolbar {
                ToolbarCloseButton(onClose: onClose)
            }
            .navigationDestination(for: NewChatRoute.self) { route in
                switch route {
                case .newGroup:
                    Text("Add new group")
                }
            }
            .sheet(item: $router.activeSheet) { sheet in
                switch sheet{
                case .addContact:
                    AddContactView(viewModel: .init())
                }
            }
        }
    }
}
