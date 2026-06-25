//
//  ScannerOverlay.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

import SwiftUI

struct ScannerOverlay: View {
    let scannerSize: CGFloat
    @State private var isAnimating = false
    var body: some View {
        GeometryReader { proxy in
            let size: CGFloat = scannerSize
            let rect = CGRect(
                x: (proxy.size.width - size) / 2,
                y: (proxy.size.height - size) / 2,
                width: size,
                height: size
            )

            Path { path in
                path.addRect(CGRect(origin: .zero, size: proxy.size))
                path.addRoundedRect(
                    in: rect,
                    cornerSize: CGSize(
                        width: AppRadius.sm,
                        height: AppRadius.sm
                    )
                )
            }
            .fill(
                .black.opacity(0.55),
                style: FillStyle(eoFill: true)
            )
            .overlay {
                roundedCutCorners
            }
        }
        .ignoresSafeArea()
        .task {
            withAnimation(.easeInOut(duration: 1.35).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
    }
    
    var roundedCutCorners: some View {
        let size = max(scannerSize - 2, 0)
        let center: CGFloat = 0.625
        let length: CGFloat = 0.06
        return ZStack {
            ForEach(0...4, id: \.self) { index in
                let rotation = Double(index) * 90
                RoundedRectangle(
                    cornerSize: .init(width: AppRadius.sm, height: AppRadius.sm)
                )
                .trim(
                    from: center - length / 2,
                    to: center + length / 2
                )
                .stroke(AppColors.accent, lineWidth: 4)
                .rotationEffect(.init(degrees: rotation))
                .opacity(isAnimating ? 0 : 1)
            }
        }
        .frame(width: size, height: size)
    }
}
