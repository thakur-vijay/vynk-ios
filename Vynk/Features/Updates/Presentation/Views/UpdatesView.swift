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
            List{
                Section {
                    StatusSectionView()
                        .clearListRowStyle()
                }
                Section {
                    ChannelsSectionView()
                        .clearListRowStyle()
                }
            }
            .listStyle(.plain)
            .listSectionSpacing(20)
            .listRowSpacing(0)
            .environment(\.defaultMinListRowHeight, 0)
            .navigationTitle("Updates")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            
                        } label: {
                            Label("Select channels", systemImage: AppSymbols.checkmarkCircle.name)
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Create channel", systemImage: AppSymbols.create.name)
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Status privacy", systemImage: AppSymbols.lock.name)
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
