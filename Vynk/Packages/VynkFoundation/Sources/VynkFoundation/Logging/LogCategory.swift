//
//  LogCategory.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//


import Foundation

public enum LogCategory: String, Sendable {
    case general = "General"

    // Core
    case app = "App"
    case lifecycle = "Lifecycle"

    // Infrastructure
    case networking = "Networking"
    case storage = "Storage"
    case permissions = "Permissions"

    // Features
    case authentication = "Authentication"
    case chat = "Chat"
    case media = "Media"
    case calls = "Calls"
    case notifications = "Notifications"
}