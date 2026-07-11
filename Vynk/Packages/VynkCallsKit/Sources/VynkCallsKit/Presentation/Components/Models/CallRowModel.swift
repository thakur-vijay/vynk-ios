//
//  CallRowModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import Foundation
import SwiftUI
import VynkDesignSystem

struct CallRowModel: Identifiable {
    let id: String
    let avatarURL: String?
    let name: String
    let subtitle: String
    let timestamp: String
    let type: CallType
    let mode: CallMode
    
    static let sampleList: [CallRowModel] = [
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/13473569/pexels-photo-13473569.jpeg",
            name: "Vijay Thakur",
            subtitle: "Outgoing",
            timestamp: "09:00 AM",
            type: .outgoing,
            mode: .audio
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/10754449/pexels-photo-10754449.jpeg",
            name: "Rahul Sharma",
            subtitle: "Missed",
            timestamp: "09:12 AM",
            type: .missed,
            mode: .video
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/7725625/pexels-photo-7725625.jpeg",
            name: "Aman Verma",
            subtitle: "Incoming",
            timestamp: "09:30 AM",
            type: .incoming,
            mode: .audio
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/11011172/pexels-photo-11011172.jpeg",
            name: "Priya",
            subtitle: "Outgoing",
            timestamp: "10:00 AM",
            type: .outgoing,
            mode: .video
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/11577757/pexels-photo-11577757.jpeg",
            name: "iOS Team",
            subtitle: "Missed",
            timestamp: "10:20 AM",
            type: .missed,
            mode: .audio
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/16476075/pexels-photo-16476075.jpeg",
            name: "Akash",
            subtitle: "Incoming",
            timestamp: "10:45 AM",
            type: .incoming,
            mode: .video
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/29584856/pexels-photo-29584856.jpeg",
            name: "Sneha",
            subtitle: "Outgoing",
            timestamp: "11:00 AM",
            type: .outgoing,
            mode: .audio
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/35765312/pexels-photo-35765312.jpeg",
            name: "Design Team",
            subtitle: "Missed",
            timestamp: "11:15 AM",
            type: .missed,
            mode: .video
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/18371784/pexels-photo-18371784.jpeg",
            name: "Karan",
            subtitle: "Incoming",
            timestamp: "11:40 AM",
            type: .incoming,
            mode: .audio
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/10241191/pexels-photo-10241191.jpeg",
            name: "Anjali",
            subtitle: "Outgoing",
            timestamp: "12:05 PM",
            type: .outgoing,
            mode: .video
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/32119894/pexels-photo-32119894.jpeg",
            name: "College Group",
            subtitle: "Missed",
            timestamp: "12:20 PM",
            type: .missed,
            mode: .audio
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/16662783/pexels-photo-16662783.jpeg",
            name: "Rohit",
            subtitle: "Incoming",
            timestamp: "12:45 PM",
            type: .incoming,
            mode: .video
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/34726900/pexels-photo-34726900.jpeg",
            name: "Flutter Devs",
            subtitle: "Outgoing",
            timestamp: "01:10 PM",
            type: .outgoing,
            mode: .audio
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/32137835/pexels-photo-32137835.jpeg",
            name: "Mohit",
            subtitle: "Missed",
            timestamp: "01:25 PM",
            type: .missed,
            mode: .video
        ),
        .init(
            id: UUID().uuidString,
            avatarURL: "https://images.pexels.com/photos/9373656/pexels-photo-9373656.jpeg",
            name: "Neha",
            subtitle: "Incoming",
            timestamp: "02:00 PM",
            type: .incoming,
            mode: .audio
        )
    ]
    
    var statusSymbol: Image {
        switch (type, mode) {
        case (.incoming, .audio):
            return AppSymbols.missedPhoneCall.image
        case (.outgoing, .audio):
            return AppSymbols.outgoingPhoneCall.image
        case (.missed, .audio):
            return AppSymbols.missedPhoneCall.image
        case (.incoming, .video):
            return AppSymbols.missedVideoCall.image
        case (.outgoing, .video):
            return AppSymbols.outgoingVideoCall.image
        case (.missed, .video):
            return AppSymbols.missedVideoCall.image
            
        }
        
    }
}

enum CallType: String{

    case incoming = "Incoming"

    case outgoing = "Outgoing"

    case missed = "Missed"

    var color: Color {
        switch self {
        case .missed:
            return .red
        default:
            return AppColors.contentDeemphasized
            
        }
        
    }
}

enum CallMode {

    case audio

    case video

}
