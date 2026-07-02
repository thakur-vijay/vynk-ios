//
//  AppLockManager.swift
//  Vynk
//
//  Created by Vijay Thakur on 07/06/26.
//

import Foundation

@MainActor
@Observable
final class AppLockManager {

    private var preferences: AppPreferencesManaging

    private(set) var isLocked = false

    private(set) var backgroundDate: Date?

    init(preferences: AppPreferencesManaging) {
        self.preferences = preferences
        prepareInitialLockState()
    }

    var isEnabled: Bool {
        preferences.isAppLockEnabled
    }
    
    var lockOption: AppLockOption {
        AppLockOption(rawValue: preferences.appLockOption) ?? .immediately
    }

    func setLockOption(_ option: AppLockOption) {
        preferences.appLockOption = option.rawValue
    }

    func setEnabled(_ enabled: Bool) {
        preferences.isAppLockEnabled = enabled

        if !enabled {
            unlock()
        }
    }

    func lock() {
        guard isEnabled else { return }
        isLocked = true
    }

    func unlock() {
        backgroundDate = nil
        isLocked = false
    }

    func didEnterBackground() {
        guard isEnabled else { return }
        backgroundDate = Date()
    }

    func didBecomeActive() {
        guard let backgroundDate, isEnabled else {
            return
        }
        
        let elapsedTime = Date().timeIntervalSince(backgroundDate)
        
        if elapsedTime >= lockDelay {
            lock()
        }
        
    }
    
    var shouldShowLockScreen: Bool {
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
