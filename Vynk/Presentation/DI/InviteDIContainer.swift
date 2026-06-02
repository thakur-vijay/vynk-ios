//
//  InviteDIContainer.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation

final class InviteDIContainer {

    func makeMessageComposeView(

        phoneNumber: String?,

        onFinish: @escaping () -> Void

    ) -> MessageComposeView {

        let service = DefaultInviteMessageService()

        let useCase = PrepareInviteMessageUseCase(service: service)

        let payload = useCase.execute(phoneNumber: phoneNumber)

        return MessageComposeView(
            canSendMessage: useCase.canSendMessages(),
            payload: payload,
            onFinish: onFinish

        )

    }

}
