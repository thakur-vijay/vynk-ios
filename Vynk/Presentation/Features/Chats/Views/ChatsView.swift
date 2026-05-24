//
//  ChatsView.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import SwiftUI

struct ChatsView: View{
    @State private var searchText: String = ""
    @State private var isSearchPresented: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ChatFilterBarView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(.all, 0)

                ForEach(ChatRowModel.sampleList) { model in
                    ChatRowView(model: model)
                        .task {
                            print(index)
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(.all, 0)
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
            .searchable(text: $searchText, isPresented: $isSearchPresented, prompt: Text("Ask Meta Al or Search"))
        }
    }
    
}

#Preview {
    ChatsView()
}
//#1daa61
