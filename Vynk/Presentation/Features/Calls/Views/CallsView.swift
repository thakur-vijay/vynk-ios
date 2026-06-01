//
//  CallsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct CallsView: View {
    @State private var viewModel: CallsViewModel
    
    init(viewModel: CallsViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                CallQuickActionRowView()
                    .clearListRowStyle()
                    .padding(.top, AppSpacing.smd)
               recentTextView
                RecentCallsSectionView()
                    .clearListRowStyle(separator: .visible)
            }
            .listStyle(.plain)
            .listRowSpacing(0)
            .environment(\.defaultMinListRowHeight, 0)
            .navigationTitle("Calls")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            
                        } label: {
                            Label("Edit", systemImage: AppIcons.edit)
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Scheduled calls", systemImage: AppIcons.calendar)
                        }

                    } label: {
                       Image(systemName: "ellipsis")
                    }
                }
                ProminentToolbarButton {
                    
                }
            }
            .searchable(text: $viewModel.search)
        }
    }
    
    var recentTextView: some View {
        Text("Recent")
            .font(AppFont.title3)
            .padding(.horizontal)
            .padding(.top, AppSpacing.xlg)
            .padding(.bottom, AppSpacing.md)
            .clearListRowStyle()
    }
}

