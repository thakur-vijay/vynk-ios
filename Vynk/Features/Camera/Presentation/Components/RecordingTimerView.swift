//
//  RecordingTimerView.swift
//  Vynk
//
//  Created by Vijay Thakur on 10/06/26.
//

import SwiftUI
import VynkFoundation

struct RecordingTimerView: View {
    let time: TimeInterval
    let isRecording: Bool
    var body: some View {
        Text(time.formatDuration())
            .font(AppFont.caption)
            .fontWeight(.medium)
            .foregroundStyle(AppColors.white)
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, AppSpacing.sm)
            .background(isRecording ? AppColors.red : AppColors.secondarySurface, in: .rect(cornerRadius: AppRadius.sm, style: .continuous))
    }
}

