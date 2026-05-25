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
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            List {
                ChatFilterBarView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(.all, 0)

                ForEach(viewModel.chats) { model in
                    ChatRowView(model: model)
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
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            
                        } label: {
                            Label("Select chats", systemImage: AppIcons.checkmarkCircle)
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Read all", systemImage: AppIcons.checkmarkBubble)
                        }

                    } label: {
                       Image(systemName: "ellipsis")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                    
                    } label: {
                        Image(systemName: AppIcons.rupee)
                    }
                    
                    Button {
                    
                    } label: {
                        Image(systemName: AppIcons.camera)
                    }


                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: AppIcons.plus)
                    }
                    .frame(width: 28, height: 28)
                    .tint(AppColors.accent)
                    .buttonStyle(.glassProminent)
                }
            }
            .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchPresented, prompt: Text("Ask Meta Al or Search"))
            .navigationDestination(for: ChatsRoute.self) { route in
                switch route {
                case .detail(let model):
                    ChatDetailView(model: model)

                }
            }
            .toolbarVisibility(toolbarVisiblity, for: .tabBar)
        }
    }
    
    var toolbarVisiblity: Visibility {
        return viewModel.path.isEmpty ? .visible : .hidden
    }
    
}

#Preview {
    ChatsView(viewModel: .init())
}
//#1daa61
