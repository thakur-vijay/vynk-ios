//
//  InviteMessageService.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation

protocol InviteMessageService {

    func makeInviteMessage() -> String

    func canSendMessages() -> Bool

}
