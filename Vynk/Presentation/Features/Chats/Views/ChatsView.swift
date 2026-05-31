//
//  ChatsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct ChatsView: View{
    @State private var viewModel: ChatsViewModel
    
    init(viewModel: ChatsViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    @Environment(\.appDIContainer) private var appDiContainer
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            List {
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
                            viewModel.openChat(model)
                        }
                }
                
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .environment(\.defaultMinListRowHeight, 0)
            .navigationTitle("Chats")
            .toolbar {
                ChatsToolbarContent {
                    viewModel.isContactsPresented.toggle()
                }
            }
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchPresented, prompt: Text("Ask Meta Al or Search"))
            .navigationDestination(for: ChatsRoute.self) { route in
                switch route {
                case .detail(let model):
                    ChatDetailView(model: model, viewModel: .init()){
                        viewModel.openUserDetail()
                    }
                case .userDetail:
                    UserProfileView(viewModel: .init())

                }
            }
            .toolbarVisibility(toolbarVisiblity, for: .tabBar)
            .sheet(isPresented: $viewModel.isContactsPresented) {
                NewChatBottomSheet()
            }
        }
    }
    
    var toolbarVisiblity: Visibility {
        return viewModel.path.isEmpty ? .visible : .hidden
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

#Preview {
    ChatsView(viewModel: .init())
}
//#1daa61
