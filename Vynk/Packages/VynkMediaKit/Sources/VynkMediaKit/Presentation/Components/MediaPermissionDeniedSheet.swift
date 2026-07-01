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
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark", action: onClose)
                }
            }
        }
    }
}
