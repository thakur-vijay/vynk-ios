//
//  CustomContextMenu.swift
//  Vynk
//
//  Created by Vijay Thakur on 01/06/26.
//

import SwiftUI

struct CustomContextMenu<Content: View, Preview: View>: UIViewRepresentable {
    let actions: [UIAction]
    let content: Content
    let preview: Preview
    let cornerRadius: CGFloat

    func makeUIView(context: Self.Context) -> UIView {
        let vc = UIHostingController(rootView: content)
        let view = vc.view ?? UIView()
        view.backgroundColor = .clear
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addInteraction(interaction)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Self.Context) {
        context.coordinator.actions = actions
        context.coordinator.preview = preview
        context.coordinator.cornerRadius = cornerRadius
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(actions: actions, preview: preview, cornerRadius: cornerRadius)
    }

    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        var actions: [UIAction]
        var preview: Preview
        var cornerRadius: CGFloat

        init(actions: [UIAction], preview: Preview, cornerRadius: CGFloat) {
            self.actions = actions
            self.preview = preview
            self.cornerRadius = cornerRadius
        }

        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            configurationForMenuAtLocation location: CGPoint
        ) -> UIContextMenuConfiguration? {
            let preview = self.preview
            return UIContextMenuConfiguration(
                previewProvider: {
                    let host = UIHostingController(rootView: preview)
                    host.view.backgroundColor = .clear
                    host.view.layer.cornerRadius = 0
                    host.preferredContentSize = host.view.intrinsicContentSize
                    return host
                },
                actionProvider: { [weak self] _ in
                    UIMenu(children: self?.actions ?? [])
                }
            )
        }

        private func targetedPreview(for interaction: UIContextMenuInteraction) -> UITargetedPreview? {
            guard let view = interaction.view else { return nil }
            
            let params = UIPreviewParameters()
            params.backgroundColor = .clear
            params.visiblePath = UIBezierPath(
                roundedRect: view.bounds,
                cornerRadius: 0
            )
            let targetedView = UITargetedPreview(view: view, parameters: params)
            targetedView.view.cornerConfiguration = .corners(radius: .fixed(cornerRadius))
            targetedView.view.effectiveRadius(corner: .allCorners)
            return targetedView
        }

        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            configuration: UIContextMenuConfiguration,
            highlightPreviewForItemWithIdentifier identifier: any NSCopying
        ) -> UITargetedPreview? {
            targetedPreview(for: interaction)
        }

        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            configuration: UIContextMenuConfiguration,
            dismissalPreviewForItemWithIdentifier identifier: any NSCopying
        ) -> UITargetedPreview? {
            targetedPreview(for: interaction)
        }
    }
}
