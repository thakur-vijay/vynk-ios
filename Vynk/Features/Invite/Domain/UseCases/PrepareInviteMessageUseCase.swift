//
//  PrepareInviteMessageUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation

final class PrepareInviteMessageUseCase {

    private let service: InviteMessageService

    init(service: InviteMessageService) {

        self.service = service

    }

    func execute(phoneNumber: String?) -> InvitePayload {

        .init(

            phoneNumber: phoneNumber,

            message: service.makeInviteMessage()

        )

    }

    func canSendMessages() -> Bool {

        service.canSendMessages()

    }

}
