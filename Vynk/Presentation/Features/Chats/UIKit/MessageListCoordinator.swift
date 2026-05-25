//
//  MessageListCoordinator.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//

import UIKit
import SwiftUI

final class MessageListCoordinator: NSObject, UITableViewDelegate, UITableViewDataSource {
  
    var sections: [MessageSection]
    let screenWidth: CGFloat
    
    var didInitialScroll: Bool = false
    
    init(sections: [MessageSection], screenWidth: CGFloat) {
        self.sections = sections
        self.screenWidth = screenWidth
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let section = sections[indexPath.section]
        let message = section.messages[indexPath.row]
        let nextMessage: MessageModel? =
            indexPath.row < section.messages.count - 1
            ? section.messages[indexPath.row + 1]
            : nil
        let isLastInGroup =
            nextMessage == nil ||
            nextMessage?.isCurrentUser != message.isCurrentUser
        let previousMessage: MessageModel? =
            indexPath.row > 0
            ? section.messages[indexPath.row - 1]
            : nil
        let isNewGroup =
            previousMessage == nil ||
            previousMessage?.isCurrentUser != message.isCurrentUser
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(AppColors.chatBackground)
        cell.contentConfiguration = UIHostingConfiguration {
            MessageBubbleView(
                model: message,
                screenWidth: screenWidth,
                isLast: isLastInGroup,
                isNewGroup: isNewGroup
            )
        }
        .margins(.all, 0)

        return cell

    }
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {

        let title = sections[section].title
        let view = UIHostingController(
            rootView: Text(title)
                .font(AppFont.footnoteMedium)
                .foregroundStyle(AppColors.contentDeemphasized)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.xs)
                .background(AppColors.background, in: .capsule)
                .padding(.vertical, AppSpacing.sm)

        ).view
        view?.backgroundColor = .clear
        return view

    }
    
}
