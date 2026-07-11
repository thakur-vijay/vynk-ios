//
//  SwiftUIView.swift
//  VynkCallsKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkDesignSystem

public struct CallsView: View {
    @Bindable var store: StoreOf<CallsFeature>
    
    public init(store: StoreOf<CallsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            List {
                CallQuickActionRowView()
                    .clearListRowStyle()
                    .padding(.top, AppSpacing.md)
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
                            Label("Edit", systemImage: AppSymbols.edit.name)
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Scheduled calls", systemImage: AppSymbols.calendar.name)
                        }

                    } label: {
                       Image(systemName: "ellipsis")
                    }
                }
                ProminentToolbarButton {
                    
                }
            }
            .searchable(text: $store.search)
        }
    }
    
    var recentTextView: some View {
        Text("Recent")
            .font(AppFont.title3)
            .padding(.horizontal)
            .padding(.top, AppSpacing.xl)
            .padding(.bottom, AppSpacing.md)
            .clearListRowStyle()
    }
}

