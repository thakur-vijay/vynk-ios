//
//  MessageModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import Foundation

struct MessageModel: Identifiable, Hashable {
    let id: String

    let text: String
    
    let timestampText: String
    
    let isCurrentUser: Bool
    
    let status: MessageStatus
    
    let type: MessageType
}

enum MessageStatus: Hashable {
    case sending
    case sent
    case delivered
    case seen
}

enum MessageType: Hashable {
    case text
}

extension MessageModel {
    
    static let sampleList: [Self] = [
        
        .init(
            id: UUID().uuidString,
            text: "Hey bhai 👋",
            timestampText: "09:00 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Hello 😄",
            timestampText: "09:01 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Kal office aa raha hai kya?",
            timestampText: "09:02 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Haan bhai, around 11 tak pahuch jaunga.",
            timestampText: "09:03 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Theek hai fir lunch sath karte hain 😎",
            timestampText: "09:05 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Done 👍",
            timestampText: "09:06 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "By the way, latest build ka performance kaafi improve hua after image optimization.",
            timestampText: "09:10 AM",
            isCurrentUser: true,
            status: .delivered,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Accha? Scroll lag fix ho gaya kya?",
            timestampText: "09:11 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Haan, Nuke resize processor use kiya. Huge difference aaya memory aur FPS mein.",
            timestampText: "09:12 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Nice 🔥",
            timestampText: "09:13 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Abhi chat detail UI bana raha hu. Keyboard handling thodi annoying lag rahi 😭",
            timestampText: "09:15 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "SwiftUI mein hamesha hota hai bhai 😂",
            timestampText: "09:16 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Waise UI kaafi clean lag rahi ab app ki. Native iOS feel aa gayi.",
            timestampText: "09:18 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "That was the goal honestly. Overdesign nahi karna tha.",
            timestampText: "09:20 AM",
            isCurrentUser: true,
            status: .delivered,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Good approach 👍",
            timestampText: "09:21 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Kal ka deployment successful raha?",
            timestampText: "09:25 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Haan, but Cloudflare build initially fail ho raha tha because bun.lock issue 😭",
            timestampText: "09:26 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Classic bun moment 😂",
            timestampText: "09:27 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Fir lock regenerate karke fix ho gaya.",
            timestampText: "09:28 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Nice nice.",
            timestampText: "09:29 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Waise tu backend kab start karega?",
            timestampText: "09:30 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Pehle complete polished UI aur architecture setup kar raha hu. Fir APIs integrate karunga.",
            timestampText: "09:31 AM",
            isCurrentUser: true,
            status: .delivered,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Actually good strategy hai.",
            timestampText: "09:32 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Haan warna backend aur UI dono ek saath messy ho jaate hain.",
            timestampText: "09:33 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "True.",
            timestampText: "09:34 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Abhi next challenge smooth auto-scroll and keyboard transitions hain 😭",
            timestampText: "09:35 AM",
            isCurrentUser: true,
            status: .sent,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Wahi actual chat app engineering hai 😂",
            timestampText: "09:36 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Mujhe lagta tha chat apps simple hoti hongi 💀",
            timestampText: "09:37 AM",
            isCurrentUser: true,
            status: .delivered,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "UI simple dikhti hai. Under the hood kaafi complexity hoti hai.",
            timestampText: "09:38 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Especially realtime sync, pagination, optimistic updates, retries etc.",
            timestampText: "09:39 AM",
            isCurrentUser: false,
            status: .seen,
            type: .text
        ),

        .init(
            id: UUID().uuidString,
            text: "Exactly isi liye vynk bana raha hu 😄",
            timestampText: "09:40 AM",
            isCurrentUser: true,
            status: .seen,
            type: .text
        )
    ]
}
