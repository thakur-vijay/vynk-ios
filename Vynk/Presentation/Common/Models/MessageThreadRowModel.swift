//
//  MessageThreadRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 30/05/26.
//

import Foundation

struct MessageThreadRowModel: Identifiable, Hashable{

    let id: String = UUID().uuidString

    let avatarImage: String

    let title: String

    let lastMessage: String

    let timestampText: String

    let unreadCount: Int

    let isPinned: Bool

    let isMuted: Bool
    
    let isYou: Bool
    
    let isLastMessageDelivered: Bool
    
    let isLastMessageSeen: Bool
    
    static var sampleList: [Self] = [
        .init(
            avatarImage: "https://images.pexels.com/photos/13473569/pexels-photo-13473569.jpeg",
            title: "Vijay Thakur",
            lastMessage: "This is my personal message I have sent to myself",
            timestampText: "09:00 AM",
            unreadCount: 0,
            isPinned: true,
            isMuted: false,
            isYou: true,
            isLastMessageDelivered: true,
            isLastMessageSeen: true
        ),
        .init(

                avatarImage: "https://images.pexels.com/photos/10754449/pexels-photo-10754449.jpeg",

                title: "Rahul Sharma",

                lastMessage: "Bhai kal milte hain, kaafi time ho gaya properly baat kiye hue.",

                timestampText: "09:00 AM",

                unreadCount: 2,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),
        .init(

                avatarImage: "https://images.pexels.com/photos/7725625/pexels-photo-7725625.jpeg",

                title: "Aman Verma",

                lastMessage: "Photo bhej di check kar aur bata kaisi lagi editing.",

                timestampText: "09:12 AM",

                unreadCount: 0,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),
        .init(

                avatarImage: "https://images.pexels.com/photos/11011172/pexels-photo-11011172.jpeg",

                title: "Priya",

                lastMessage: "Okay done 👍",

                timestampText: "09:30 AM",

                unreadCount: 1,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/11577757/pexels-photo-11577757.jpeg",

                title: "iOS Team",

                lastMessage: "Hey everyone, the latest TestFlight build has been uploaded successfully. Please verify onboarding, media upload, and notification flows before EOD.",

                timestampText: "10:00 AM",

                unreadCount: 5,

                isPinned: false,

                isMuted: true,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/16476075/pexels-photo-16476075.jpeg",

                title: "Akash",

                lastMessage: "Bro interview kaisa gaya? Call pe batana free hoke.",

                timestampText: "10:20 AM",

                unreadCount: 0,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/29584856/pexels-photo-29584856.jpeg",

                title: "Sneha",

                lastMessage: "Meeting shifted to tomorrow because client side pe kuch changes aaye hain.",

                timestampText: "10:45 AM",

                unreadCount: 3,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/35765312/pexels-photo-35765312.jpeg",

                title: "Design Team",

                lastMessage: "Updated Figma file shared with revised spacing system, typography hierarchy, and dark mode adjustments.",

                timestampText: "11:00 AM",

                unreadCount: 0,

                isPinned: false,

                isMuted: true,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/18371784/pexels-photo-18371784.jpeg",

                title: "Karan",

                lastMessage: "Call karna jab free ho, ek important baat discuss karni thi.",

                timestampText: "11:15 AM",

                unreadCount: 4,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: false,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/10241191/pexels-photo-10241191.jpeg",

                title: "Anjali",

                lastMessage: "Thanks 😊",

                timestampText: "11:40 AM",

                unreadCount: 0,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/32119894/pexels-photo-32119894.jpeg",

                title: "College Group",

                lastMessage: "Guys don’t forget to upload the final assignment PDF before midnight otherwise submissions close automatically.",

                timestampText: "12:05 PM",

                unreadCount: 9,

                isPinned: false,

                isMuted: true,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/16662783/pexels-photo-16662783.jpeg",

                title: "Rohit",

                lastMessage: "Gym aa raha hai kya aaj? Leg day skip mat karna 😭",

                timestampText: "12:20 PM",

                unreadCount: 1,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/34726900/pexels-photo-34726900.jpeg",

                title: "Flutter Devs",

                lastMessage: "New package released with performance improvements and updated animation APIs.",

                timestampText: "12:45 PM",

                unreadCount: 0,

                isPinned: false,

                isMuted: true,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/32137835/pexels-photo-32137835.jpeg",

                title: "Mohit",

                lastMessage: "Bhai payment received successfully 👍",

                timestampText: "01:10 PM",

                unreadCount: 0,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/9373656/pexels-photo-9373656.jpeg",

                title: "Neha",

                lastMessage: "Reached home safely, thanks for checking 😊",

                timestampText: "01:25 PM",

                unreadCount: 2,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/34042086/pexels-photo-34042086.jpeg",

                title: "Startup Founders",

                lastMessage: "We should finalize the investor pitch deck tonight because tomorrow’s meeting could define the next funding round.",

                timestampText: "02:00 PM",

                unreadCount: 6,

                isPinned: false,

                isMuted: true,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/35327568/pexels-photo-35327568.jpeg",

                title: "Arjun",

                lastMessage: "Let’s ship it 🚀",

                timestampText: "02:20 PM",

                unreadCount: 0,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/18001795/pexels-photo-18001795.jpeg",

                title: "Family",

                lastMessage: "Dinner at 8 PM, sab time pe aa jana please.",

                timestampText: "03:00 PM",

                unreadCount: 7,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/34802423/pexels-photo-34802423.jpeg",

                title: "Harsh",

                lastMessage: "MacBook battery issue solve hua ya abhi bhi drain ho rahi hai?",

                timestampText: "03:25 PM",

                unreadCount: 0,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: false,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/1327888/pexels-photo-1327888.jpeg",

                title: "Backend Team",

                lastMessage: "The API response structure has been optimized and pagination is now cursor-based instead of offset-based.",

                timestampText: "04:00 PM",

                unreadCount: 3,

                isPinned: false,

                isMuted: true,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: false

            ),

            .init(

                avatarImage: "https://images.pexels.com/photos/33676335/pexels-photo-33676335.jpeg",

                title: "Sahil",

                lastMessage: "See you tomorrow 👋",

                timestampText: "04:30 PM",

                unreadCount: 0,

                isPinned: false,

                isMuted: false,

                isYou: false,

                isLastMessageDelivered: true,

                isLastMessageSeen: true

            )

    ]

}
