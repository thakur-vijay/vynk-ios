//
//  MessagesListUI.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import SwiftUI
import UIKit

struct MessagesListUI: UIViewRepresentable {
    let sections: [MessageSection]
    let screenWidth: CGFloat

    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = context.coordinator
        tableView.dataSource = context.coordinator
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(AppColors.chatBackground)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 80

        tableView.rowHeight = UITableView.automaticDimension

        tableView.contentInsetAdjustmentBehavior = .never
        return tableView

    }


    func updateUIView(_ tableView: UITableView, context: Context) {
        context.coordinator.sections = sections
        tableView.reloadData()
        guard !context.coordinator.didInitialScroll else { return }
        context.coordinator.didInitialScroll = true
        tableView.performBatchUpdates(nil) { _ in
            tableView.layoutIfNeeded()
            scrollToAbsoluteBottom(tableView)
        }

    }

    func makeCoordinator() -> MessageListCoordinator {

        MessageListCoordinator(

            sections: sections,

            screenWidth: screenWidth

        )

    }
    
    private func scrollToAbsoluteBottom(_ tableView: UITableView) {
        let bottomY = tableView.contentSize.height

            - tableView.bounds.height

            + tableView.adjustedContentInset.bottom

        tableView.setContentOffset(

            CGPoint(x: 0, y: max(bottomY, -tableView.adjustedContentInset.top)),

            animated: false

        )

    }

}
