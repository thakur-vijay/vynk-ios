//
//  DefaultInviteMessageService.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import MessageUI

final class DefaultInviteMessageService: InviteMessageService {

    func canSendMessages() -> Bool {

        MFMessageComposeViewController.canSendText()

    }

    func makeInviteMessage() -> String {

        """

        Hey! I'm using Vynk.

        Join me on Vynk and start chatting instantly.

        https://vynk.app/download

        """

    }

}
