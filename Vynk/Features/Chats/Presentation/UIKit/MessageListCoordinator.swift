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
    weak var tableView: UITableView?
    private var currentKeyboardOverlap: CGFloat = 0
    
    init(sections: [MessageSection], screenWidth: CGFloat) {
        self.sections = sections
        self.screenWidth = screenWidth
        super.init()
        observeKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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

private extension MessageListCoordinator {

    func observeKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardFrameChange),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardFrameChange),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func handleKeyboardFrameChange(_ notification: Notification) {

        guard

            let tableView,

            let userInfo = notification.userInfo,

            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,

            let window = tableView.window

        else { return }

        let screenHeight = window.bounds.height

        let newOverlap = max(0, screenHeight - keyboardFrame.minY)

        let delta = newOverlap - currentKeyboardOverlap        
        guard abs(delta) > 20 else {

            currentKeyboardOverlap = newOverlap

            return

        }

        currentKeyboardOverlap = newOverlap

        currentKeyboardOverlap = newOverlap
        let wasAtBottom = isNearBottom(tableView)
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25

        let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 7

        let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
        Log.info(wasAtBottom, String(describing: self))
        let inputBarHeight: CGFloat = 30
        let correctedDelta = delta - inputBarHeight
        UIView.animate(

            withDuration: duration,

            delay: 0,

            options: [.beginFromCurrentState, options]

        ) {

            if wasAtBottom {

                self.scrollToAbsoluteBottom(tableView)

            } else {

                tableView.contentOffset.y += correctedDelta

            }

            tableView.superview?.layoutIfNeeded()
            tableView.layoutIfNeeded()

        }

    }

    func isNearBottom(_ tableView: UITableView) -> Bool {
        
        tableView.layoutIfNeeded()
        
        
        
        let bottomY = tableView.contentSize.height
        
        - tableView.bounds.height
        
        + tableView.contentInset.bottom
        
        
        
        let targetY = max(
            
            bottomY,
            
            -tableView.contentInset.top
            
        )
        
        
        
        let threshold: CGFloat = 80
        
        
        
        return tableView.contentOffset.y >= targetY - threshold
        
    }

    private func scrollToAbsoluteBottom(_ tableView: UITableView) {
        let bottomY = tableView.contentSize.height
            - tableView.bounds.height
            + tableView.contentInset.bottom

        tableView.setContentOffset(

            CGPoint(x: 0, y: max(bottomY, -tableView.contentInset.top)),

            animated: false

        )

    }
}
