//
//  AppLockManager.swift
//  VynkSecurity
//
//  Created by Vijay Thakur on 03/07/26.
//


import Foundation

@available(iOS 17.0, *)
@MainActor
@Observable
public final class AppLockManager {

    private var preferences: AppLockPreferences

    private(set) var isLocked = false

    private(set) var backgroundDate: Date?

    public init(preferences: AppLockPreferences) {
        self.preferences = preferences
        prepareInitialLockState()
    }

    public var isEnabled: Bool {
        preferences.isAppLockEnabled
    }
    
    public var lockOption: AppLockOption {
        AppLockOption(rawValue: preferences.appLockOption) ?? .immediately
    }

    public func setLockOption(_ option: AppLockOption) {
        preferences.appLockOption = option.rawValue
    }

    public func setEnabled(_ enabled: Bool) {
        preferences.isAppLockEnabled = enabled

        if !enabled {
            unlock()
        }
    }

    public func lock() {
        guard isEnabled else { return }
        isLocked = true
    }

    public func unlock() {
        backgroundDate = nil
        isLocked = false
    }

    public func didEnterBackground() {
        guard isEnabled else { return }
        backgroundDate = Date()
    }

    public func didBecomeActive() {
        guard let backgroundDate, isEnabled else {
            return
        }
        
        let elapsedTime = Date().timeIntervalSince(backgroundDate)
        
        if elapsedTime >= lockDelay {
            lock()
        }
        
    }
    
    public var shouldShowLockScreen: Bool {
        return isEnabled && isLocked
    }
    
    func prepareInitialLockState() {
        if isEnabled {
            isLocked = true
        } else {
            isLocked = false
        }
        
    }
    
    private var lockDelay: TimeInterval {
        
        switch lockOption {
            
        case .immediately:
            
            return 0
            
        case .afterOneMinute:
            
            return 60
            
        case .afterFifteenMinutes:
            
            return 15 * 60
            
        case .afterOneHour:
            
            return 60 * 60
            
        }
        
    }
}
