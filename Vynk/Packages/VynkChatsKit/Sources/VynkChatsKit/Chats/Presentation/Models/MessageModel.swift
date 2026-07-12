//
//  MessageModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import Foundation

public struct MessageModel: Identifiable, Hashable {

    public let id: String

    public let text: String

    public let sentAt: Date

    public let isCurrentUser: Bool

    public let status: MessageStatus

    public let type: MessageType

    

    public var timestampText: String {

        sentAt.formatted(date: .omitted, time: .shortened)

    }

}

public extension MessageModel {

    nonisolated(unsafe) static let sampleList: [Self] = [

        .sample("1", "Hey bhai 👋", "2026-05-23T09:00:00+05:30", false, .seen),

        .sample("2", "Hello 😄", "2026-05-23T09:01:00+05:30", true, .seen),

        .sample("3", "Kal office aa raha hai kya?", "2026-05-23T09:02:00+05:30", false, .seen),

        .sample("4", "Haan bhai, around 11 tak pahuch jaunga.", "2026-05-23T09:03:00+05:30", true, .seen),

        .sample("5", "Theek hai fir lunch sath karte hain 😎", "2026-05-23T09:05:00+05:30", false, .seen),

        .sample("6", "Done 👍", "2026-05-23T09:06:00+05:30", true, .seen),

        .sample("7", "By the way, latest build ka performance kaafi improve hua after image optimization.", "2026-05-23T09:10:00+05:30", true, .delivered),

        .sample("8", "Accha? Scroll lag fix ho gaya kya?", "2026-05-23T09:11:00+05:30", false, .seen),

        .sample("9", "Haan, Nuke resize processor use kiya. Huge difference aaya memory aur FPS mein.", "2026-05-23T09:12:00+05:30", true, .seen),

        .sample("10", "Nice 🔥", "2026-05-24T09:13:00+05:30", false, .seen),

        .sample("11", "Abhi chat detail UI bana raha hu. Keyboard handling thodi annoying lag rahi 😭", "2026-05-24T09:15:00+05:30", true, .seen),

        .sample("12", "SwiftUI mein hamesha hota hai bhai 😂", "2026-05-24T09:16:00+05:30", false, .seen),

        .sample("13", "Waise UI kaafi clean lag rahi ab app ki. Native iOS feel aa gayi.", "2026-05-24T09:18:00+05:30", false, .seen),

        .sample("14", "That was the goal honestly. Overdesign nahi karna tha.", "2026-05-24T09:20:00+05:30", true, .delivered),

        .sample("15", "Good approach 👍", "2026-05-24T09:21:00+05:30", false, .seen),

        .sample("16", "Kal ka deployment successful raha?", "2026-05-25T09:25:00+05:30", false, .seen),

        .sample("17", "Haan, but Cloudflare build initially fail ho raha tha because bun.lock issue 😭", "2026-05-25T09:26:00+05:30", true, .seen),

        .sample("18", "Classic bun moment 😂", "2026-05-25T09:27:00+05:30", false, .seen),

        .sample("19", "Fir lock regenerate karke fix ho gaya.", "2026-05-25T09:28:00+05:30", true, .seen),

        .sample("20", "Nice nice.", "2026-05-25T09:29:00+05:30", false, .seen),

        .sample("21", "Waise tu backend kab start karega?", "2026-05-25T09:30:00+05:30", false, .seen),

        .sample("22", "Pehle complete polished UI aur architecture setup kar raha hu. Fir APIs integrate karunga.", "2026-05-25T09:31:00+05:30", true, .delivered),

        .sample("23", "Actually good strategy hai.", "2026-05-25T09:32:00+05:30", false, .seen),

        .sample("24", "Haan warna backend aur UI dono ek saath messy ho jaate hain.", "2026-05-25T09:33:00+05:30", true, .seen),

        .sample("25", "True.", "2026-05-25T09:34:00+05:30", false, .seen),

        .sample("26", "Abhi next challenge smooth auto-scroll and keyboard transitions hain 😭", "2026-05-25T09:35:00+05:30", true, .sent),

        .sample("27", "Wahi actual chat app engineering hai 😂", "2026-05-25T09:36:00+05:30", false, .seen),

        .sample("28", "Mujhe lagta tha chat apps simple hoti hongi 💀", "2026-05-25T09:37:00+05:30", true, .delivered),

        .sample("29", "UI simple dikhti hai. Under the hood kaafi complexity hoti hai.", "2026-05-25T09:38:00+05:30", false, .seen),

        .sample("30", "Especially realtime sync, pagination, optimistic updates, retries etc.", "2026-05-25T09:39:00+05:30", false, .seen),

        .sample("31", "Exactly isi liye vynk bana raha hu 😄", "2026-05-25T09:40:00+05:30", true, .seen)

    ]

    private static func sample(
        _ id: String,
        _ text: String,
        _ isoDate: String,
        _ isCurrentUser: Bool,
        _ status: MessageStatus

    ) -> Self {

        .init(
            id: id,

            text: text,

            sentAt: ISO8601DateFormatter().date(from: isoDate) ?? .now,

            isCurrentUser: isCurrentUser,

            status: status,

            type: .text

        )

    }

}
