//
//  MessageComposeView.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import SwiftUI
import MessageUI

struct MessageComposeView: View {
    let canSendMessage: Bool
    let payload: InvitePayload
    let onFinish: () -> Void
    var body: some View {
        if canSendMessage {
            MessageComposeViewController(payload: payload, onFinish: onFinish)
        }else {
            EmptyView()
        }
    }
}

struct MessageComposeViewController: UIViewControllerRepresentable {

    let payload: InvitePayload
    let onFinish: () -> Void

    func makeUIViewController(
        context: Context
    ) -> MFMessageComposeViewController {

        let controller = MFMessageComposeViewController()

        controller.messageComposeDelegate = context.coordinator

        controller.body = payload.message

        if let phoneNumber = payload.phoneNumber {
            controller.recipients = [phoneNumber]
        }

        return controller
    }

    func updateUIViewController(
        _ uiViewController: MFMessageComposeViewController,
        context: Context
    ) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onFinish: onFinish)
    }
}

extension MessageComposeViewController {

    final class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {

        let onFinish: () -> Void

        init(onFinish: @escaping () -> Void) {
            self.onFinish = onFinish
        }

        func messageComposeViewController(
            _ controller: MFMessageComposeViewController,
            didFinishWith result: MessageComposeResult
        ) {

            controller.dismiss(animated: true)

            switch result {
            case .cancelled:
                print("Invite cancelled")

            case .sent:
                print("Invite sent")

            case .failed:
                print("Invite failed")

            @unknown default:
                break
            }

            onFinish()
        }
    }
}
