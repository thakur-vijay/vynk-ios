//
//  MediaDrawerView.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/07/26.
//

import SwiftUI

struct MediaDrawerView<Content: View>: View {
    let isMediaHidden: Bool
    @ViewBuilder let content: () -> Content
    let presentSheet: ()->()
    @State private var drawerHeight: CGFloat = 0

    @State private var offsetY: CGFloat = 0

    @State private var startOffsetY: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .opacity(0)
                .overlay(alignment: .bottom){
                    Capsule()
                        .fill(.white)
                        .frame(width: 40, height: 6)
                        .padding(.bottom, 12)
                }
                .contentShape(.rect)
            if !isMediaHidden{
                content()
            }
        }
        .onGeometryChange(for: CGFloat.self) {
            $0.size.height
        } action: { height in
            print(height, "Height value")
            drawerHeight = height
        }
        .offset(y: offsetY)
        .clipped()
        .contentShape(.rect)
        .compositingGroup()
        .gesture(gesture)
    }
    
    var gesture: PanGestureRecognizer {
        PanGestureRecognizer { pan in

            let translation = pan.translation(in: pan.view)
            let velocity = pan.velocity(in: pan.view)

            switch pan.state {

            case .began:

                startOffsetY = offsetY

            case .changed:

                let proposed = startOffsetY + translation.y

                // Rubber banding
                if proposed < 0 {
                    offsetY = proposed * 0.2
                } else if proposed > (drawerHeight - 50) {
                    offsetY = (drawerHeight - 50) + (proposed - (drawerHeight - 50)) * 0.2
                } else {
                    offsetY = proposed
                }

            case .ended, .cancelled:

                withAnimation(.smooth(duration: 0.28)) {

                    if isMediaHidden {
                        offsetY = 0
                        presentSheet()
                    }else {
                        if velocity.y > 700 {
                            // Fast swipe down
                            offsetY = (drawerHeight - 50)

                        } else if velocity.y < -700 {
                            // Fast swipe up
                            offsetY = 0

                        } else {

                            // Slow drag
                            offsetY =
                                offsetY > (drawerHeight - 50) * 0.5
                                ? (drawerHeight - 50)
                                : 0
                        }
                    }
                }

            default:
                break
            }
        }

    }
}

struct PanGestureRecognizer: UIGestureRecognizerRepresentable {

    let action: (UIPanGestureRecognizer) -> Void

    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        Coordinator(action: action)
    }

    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let recognizer = UIPanGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handlePan(_:))
        )

        recognizer.cancelsTouchesInView = false

        return recognizer
    }

    func updateUIGestureRecognizer(
        _ recognizer: UIPanGestureRecognizer,
        context: Context
    ) {
    }

    final class Coordinator: NSObject {

        let action: (UIPanGestureRecognizer) -> Void

        init(action: @escaping (UIPanGestureRecognizer) -> Void) {
            self.action = action
        }

        @objc
        func handlePan(_ recognizer: UIPanGestureRecognizer) {

            let point = recognizer.location(in: recognizer.view)

            print(String(describing: recognizer.view))
            print(String(describing: recognizer.view?.hitTest(point, with: nil)))

            action(recognizer)
        }
    }
}
