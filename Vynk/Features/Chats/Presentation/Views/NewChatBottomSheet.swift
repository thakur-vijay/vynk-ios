//
//  NewChatBottomSheet.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct NewChatBottomSheet: View {
    @State private var viewModel: NewChatBottomSheetViewModel
    @State private var router: NewChatRouter
    let diContainer: NewChatDIContainer
    let onClose: ()->()
    init(
        viewModel: NewChatBottomSheetViewModel,
        router: NewChatRouter,
        diContainer: NewChatDIContainer,
        onClose: @escaping () -> Void
    ) {
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
        self.diContainer = diContainer
        self.onClose = onClose
    }
    
    @Environment(\.appDIContainer) private var appDIContainer
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
                diContainer.makeContactsView { phone in
                    router.presentSheet(.invite(phone))
                }
            }
            .listSectionSpacing(.custom(0))
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
                    diContainer.makeAddContactView{
                        router.dismissSheet()
                    }
                case .invite(let phone):
                    diContainer.makeInviteView(phone: phone) {
                    }
                }
            }
        }
    }
}
