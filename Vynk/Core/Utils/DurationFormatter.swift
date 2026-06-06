//
//  DurationFormatter.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation

enum DurationFormatter {
    
    static func formatDuration(duration: TimeInterval?)->String {
        guard let duration else {
            return ""
        }

        let totalSeconds = Int(duration)

        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(
                format: "%d:%02d:%02d",
                hours,
                minutes,
                seconds
            )
        }

        return String(
            format: "%d:%02d",
            minutes,
            seconds
        )
    }
}
