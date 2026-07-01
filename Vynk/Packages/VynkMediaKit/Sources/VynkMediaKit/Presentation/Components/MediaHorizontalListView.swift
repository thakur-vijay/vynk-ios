//
//  File.swift
//  VynkMediaKit
//
//  Created by Vijay Thakur on 01/07/26.
//

import SwiftUI

@available(iOS 18.0, *)
public struct MediaHorizontalListView: View {
    @State private var viewModel: MediaPickerViewModel
    private let diContainer: MediaPickerDIContainer
    let result: (MediaModel?)->()
    
    init(
        viewModel: MediaPickerViewModel,
        diContaier: MediaPickerDIContainer,
        result: @escaping (MediaModel?)->()
    ){
        _viewModel = State(wrappedValue: viewModel)
        self.diContainer = diContaier
        self.result = result
    }
    
    public var body: some View {
        ScrollView(.horizontal){
            
        }
        .task {
            await viewModel.loadMedia()
            viewModel.loadAlbums()
        }
    }
}

