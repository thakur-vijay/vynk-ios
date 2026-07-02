//
//  AppIcons.swift
//  Vynk
//
//  Created by Vijay Thakur on 21/05/26.
//

import Foundation

import SwiftUI

public struct AppSymbol: Sendable {

    public let name: String

    public init(_ name: String) {
        self.name = name
    }

    public var image: Image {
        Image(systemName: name)
    }

#if canImport(UIKit)
    
    public var uiImage: UIImage? {
        
        UIImage(systemName: name)
        
    }
    
#endif
}

public enum AppSymbols {

    public static let pin = AppSymbol("pin")
    public static let pinSlash = AppSymbol("pin.slash.fill")
    public static let messageFill = AppSymbol("message.fill")
    public static let message = AppSymbol("message")
    public static let plus = AppSymbol("plus")
    public static let plusFill = AppSymbol("plus.circle.fill")
    public static let checkmarkCircle = AppSymbol("checkmark.circle")
    public static let checkmarkBubble = AppSymbol("checkmark.bubble")
    public static let checkmark = AppSymbol("checkmark")
    public static let bellSlash = AppSymbol("bell.slash")
    public static let bell = AppSymbol("bell")
    public static let heart = AppSymbol("heart")
    public static let heartFill = AppSymbol("heart.fill")
    public static let trash = AppSymbol("trash")
    public static let xmarkCircle = AppSymbol("xmark.circle")
    public static let close = AppSymbol("xmark")
    public static let nosign = AppSymbol("nosign")
    public static let settings = AppSymbol("gearshape.fill")
    public static let group = AppSymbol("person.3")
    public static let calls = AppSymbol("phone.down.waves.left.and.right")
    public static let dashedCircle = AppSymbol("circle.dashed")
    public static let camera = AppSymbol("camera.fill")
    public static let rupeeFill = AppSymbol("indianrupeesign.circle.fill")
    public static let rupee = AppSymbol("indianrupeesign.circle")
    public static let phone = AppSymbol("phone")
    public static let video = AppSymbol("video")
    public static let videoFill = AppSymbol("video.fill")
    public static let send = AppSymbol("paperplane.fill")
    public static let doubleTick = AppSymbol("double.tick")
    public static let reply = AppSymbol("arrowshape.turn.up.left")
    public static let forward = AppSymbol("arrowshape.turn.up.right")
    public static let copy = AppSymbol("document.on.document")
    public static let info = AppSymbol("info.circle")
    public static let star = AppSymbol("star")
    public static let ellipsisCircle = AppSymbol("ellipsis.circle")
    public static let translate = AppSymbol("translate")
    public static let search = AppSymbol("magnifyingglass")
    public static let photo = AppSymbol("photo")
    public static let storage = AppSymbol("externaldrive")
    public static let palette = AppSymbol("paintpalette")
    public static let download = AppSymbol("square.and.arrow.down")
    public static let timer = AppSymbol("gauge.with.needle")
    public static let lockOpen = AppSymbol("lock.rotation.open")
    public static let lock = AppSymbol("lock")
    public static let shield = AppSymbol("shield.checkerboard")
    public static let personCircle = AppSymbol("person.crop.circle")
    public static let person = AppSymbol("person.fill")
    public static let newGroup = AppSymbol("person.2")
    public static let newPerson = AppSymbol("person.badge.plus")
    public static let qrcode = AppSymbol("qrcode")
    public static let laptop = AppSymbol("laptopcomputer")
    public static let key = AppSymbol("key")
    public static let appBadge = AppSymbol("app.badge")
    public static let questionmarkCircle = AppSymbol("questionmark.circle")
    public static let calendar = AppSymbol("calendar")
    public static let megaphone = AppSymbol("megaphone")
    public static let missedPhoneCall = AppSymbol("phone.arrow.down.left.fill")
    public static let outgoingPhoneCall = AppSymbol("phone.arrow.up.right.fill")
    public static let missedVideoCall = AppSymbol("arrow.down.left.video.fill")
    public static let outgoingVideoCall = AppSymbol("arrow.up.right.video.fill")
    public static let threeDots = AppSymbol("ellipsis")
    public static let edit = AppSymbol("pencil.line")
    public static let pencil = AppSymbol("pencil")
    public static let create = AppSymbol("plus.circle.dashed")
    public static let hide = AppSymbol("eye.slash")
    public static let grid = AppSymbol("square.grid.2x2")
    public static let rightChevron = AppSymbol("chevron.right")
    public static let broadcast = AppSymbol("megaphone")
    public static let warning = AppSymbol("exclamationmark.triangle")
    public static let switchPath = AppSymbol("arrow.2.circlepath")
    public static let filter = AppSymbol("wand.and.sparkles")
    public static let flashOff = AppSymbol("bolt.slash.fill")
    public static let flashOn = AppSymbol("bolt.fill")
    public static let flashAuto = AppSymbol("bolt.badge.automatic.fill")
    public static let bag = AppSymbol("gym.bag.fill")

    public enum ChatAction {
        public static let pin = AppSymbol("pin.fill")
        public static let markUnreadSwipe = AppSymbol("message.badge.filled.fill")
        public static let markUnreadMenu = AppSymbol("message.badge")
        public static let archiveSwipe = AppSymbol("archivebox.fill")
        public static let archiveMenu = AppSymbol("archivebox")
        public static let addToListMenu = AppSymbol("person.crop.rectangle.stack")
    }

    public enum Heart {
        public static let heart = AppSymbol("heart")
        public static let heartFill = AppSymbol("heart.fill")
    }

    public enum Share {
        public static let share = AppSymbol("square.and.arrow.up")
    }
}
