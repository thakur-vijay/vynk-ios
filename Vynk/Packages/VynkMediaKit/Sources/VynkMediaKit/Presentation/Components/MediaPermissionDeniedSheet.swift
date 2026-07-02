//
//  File.swift
//  VynkMediaKit
//
//  Created by Vijay Thakur on 01/07/26.
//

import SwiftUI

@available(iOS 16.0, *)
public struct MediaPermissionDeniedSheet: View {
    let openSettings: ()->()
    let onClose: ()->()
    public var body: some View {
        NavigationStack {
            VStack(spacing: 16){
                Text("Vynk does not have access to Photos")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Text("To allow access and see your full photo library, go to")
                    .font(.caption)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark", action: onClose)
                        .glassButton()
                }
            }
        }
    }
}

extension View {
    @ViewBuilder
    func glassButton()-> some View {
        if #available(iOS 26, *){
            self
                .glassEffect(.regular.interactive(), in: .circle)
        }else {
            self
                .background(.ultraThinMaterial, in: .circle)
        }
    }
}
