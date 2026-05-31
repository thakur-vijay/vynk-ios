//
//  ChatsDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

final class ChatsDIContainer {

    func makeChatsView() -> ChatsView {

        let router = ChatsRouter()

        let viewModel = ChatsViewModel(
            router: router
        )

        return ChatsView(
            viewModel: viewModel
        )
    }
}
