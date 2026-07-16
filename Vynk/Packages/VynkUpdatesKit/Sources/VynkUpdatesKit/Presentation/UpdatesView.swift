//
//  SwiftUIView.swift
//  VynkUpdatesKit
//
//  Created by Vijay Thakur on 11/07/26.
//

import SwiftUI
import ComposableArchitecture
import VynkStatusKit
import VynkDesignSystem
import VynkChannelKit

public struct UpdatesView: View {
    @Bindable var store: StoreOf<UpdatesFeature>
    
    public init(store: StoreOf<UpdatesFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            List{
                Section {
                    StatusesView(
                        store: store.scope(
                            \.status,
                             action: \.status
                        )
                    )
                    .clearListRowStyle()
                }
                
                Section {
                    ChannelsView(
                        store: store.scope(
                            \.channels,
                             action: \.channels
                        )
                    )
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
//            .searchable(text: $store.search)
        }
    }
}
