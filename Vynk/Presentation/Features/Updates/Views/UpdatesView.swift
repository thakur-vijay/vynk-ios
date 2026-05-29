//
//  UpdatesView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct UpdatesView: View {
    @State private var viewModel: UpdatesViewModel
    
    init(viewModel: UpdatesViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: AppSpacing.lg) {
                    StatusSectionView()
                    ChannelsSectionView()
                }
                .padding(.vertical)
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .environment(\.defaultMinListRowHeight, 0)
            .navigationTitle("Updates")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            
                        } label: {
                            Label("Select channels", systemImage: AppIcons.checkmarkCircle)
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Create channel", systemImage: AppIcons.create)
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Status privacy", systemImage: AppIcons.lock)
                        }


                    } label: {
                       Image(systemName: "ellipsis")
                    }
                }
            }
            .searchable(text: $viewModel.search)
        }
    }
}
