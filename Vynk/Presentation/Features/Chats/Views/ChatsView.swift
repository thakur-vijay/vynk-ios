//
//  ChatsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct ChatsView: View{
    @State private var viewModel: ChatsViewModel
    @State private var router: ChatsRouter
    
    
    init(viewModel: ChatsViewModel, router: ChatsRouter) {
        _viewModel = State(wrappedValue: viewModel)
        _router = State(wrappedValue: router)
    }
    
    @Environment(\.appDIContainer) private var appDiContainer
    
    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                if !viewModel.isPermissionStatusCardHidden {
                    ContactsPermissionCard {
                        viewModel.hidePermissionStatusCard()
                    }
                }
                ChatFilterBarView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(.all, 0)

                ForEach(viewModel.chats) { model in
                    MessageThreadRowView(model: model)
                        .swipeActions(edge: .leading) {
                            swipeButton(AppIcons.ChatAction.markUnreadSwipe, label: "Unread", tint: AppColors.accentEmphasized) {
                                
                            }
                            swipeButton(AppIcons.pinSlash, label: "Pin", tint: AppColors.neutralMuted) {
                                
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            swipeButton(AppIcons.ChatAction.archiveSwipe, label: "Archive", tint: AppColors.accentEmphasized) {
                                
                            }
                            
                            swipeButton("ellipsis", label: "More", tint: AppColors.neutralMuted) {
                                
                            }
                        }
                        .contextMenu {
                            ChatContextMenu(userName: model.title) { action in
                                
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.all, 0)
                        .contentShape(.rect)
                        .onTapGesture {
                            router.push(.detail(model))
                        }
                }
                
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .environment(\.defaultMinListRowHeight, 0)
            .navigationTitle("Chats")
            .toolbar {
                ChatsToolbarContent {
                    router.presentSheet(.newChat)
                } onCameraTap: {
                    router.presentFullScreenCover(.camera)
                }
            }
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchPresented, prompt: Text("Ask Meta Al or Search"))
            .navigationDestination(for: ChatsRoute.self) { route in
                switch route {
                case .detail(let model):
                    ChatDetailView(model: model, viewModel: .init()){
                        router.push(.userDetail)
                    }
                case .userDetail:
                    UserProfileView(viewModel: .init())

                }
            }
            .sheet(item: $router.activeSheet, onDismiss: {
                viewModel.handlePermissionStatusCard()
            }) { sheet in
                switch sheet {
                case .newChat:
                    appDiContainer.chatsDIContainer.makeNewChatBottomSheet {
                        router.dismissSheet()
                    }
                case .mediaPicker:
                    appDiContainer.mediaPickerDIContainer.makeView {
                        router.dismissSheet()
                    }
                }
            }
            .fullScreenCover(item: $router.activeFullScreenCover){ fullScreenCover in
                switch fullScreenCover {
                case .camera: appDiContainer.chatsDIContainer.makeCameraFullScreenCover {
                    router.dismissFullScreenCover()
                }
                }
            }
            .toolbarVisibility(toolbarVisiblity, for: .tabBar)
            .task {
                viewModel.handlePermissionStatusCard()
            }
        }
    }
    
    var toolbarVisiblity: Visibility {
        return router.path.isEmpty ? .visible : .hidden
    }
    
    @ViewBuilder
    func swipeButton(_ icon: String, label: String, tint: Color, action: ()->())-> some View {
        Button {
            
        } label: {
            VStack {
                Image(systemName: icon)
                Text(label)
            }
        }
        .tint(tint)
        
    }
    
}
