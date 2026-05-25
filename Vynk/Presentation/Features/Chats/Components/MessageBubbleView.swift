//
//  MessageBubbleView.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import SwiftUI

struct MessageBubbleView: View {
    let model: MessageModel
    let screenWidth: CGFloat
    let isLast: Bool
    var body: some View {
        VStack {
            switch model.type {
            case .text: textView
            }
        }
        .frame(maxWidth: screenWidth * 0.8, alignment: model.isCurrentUser ? .trailing : .leading)
        .hSpacing(model.isCurrentUser ? .trailing : .leading)
        .padding(.horizontal, AppSpacing.md)
    }
    
    var textView: some View {
        VStack(alignment: .trailing, spacing: AppSpacing.xxs){
            Text(model.text)
                .foregroundStyle(AppColors.contentDefault)
                .font(AppFont.subheadline)
            HStack(spacing: AppSpacing.xxs){
                Text(model.timestampText)
                    .font(AppFont.footnote)
                    .foregroundStyle(AppColors.contentDeemphasized)
                if model.isCurrentUser{
                    Image(AppIcons.doubleTick)
                        .font(AppFont.footnote)
                        .foregroundStyle(.contentRead)
                }
            }
        }
        .padding(.vertical, AppSpacing.sm)
        .padding(.horizontal, AppSpacing.md)
        .background(bubbleBackground)
        .overlay {
            BubbleShape(myMessage: model.isCurrentUser, showsTail: isLast)
                .stroke(AppColors.linesOutlineDeemphasized, lineWidth: 0.5)
        }
        .clipShape(BubbleShape(myMessage: model.isCurrentUser, showsTail: isLast))
        .contentShape(.contextMenuPreview, BubbleShape(myMessage: model.isCurrentUser, showsTail: isLast))
        .compositingGroup()
        .contextMenu {
            Button("Reply", systemImage: AppIcons.reply) {
                
            }
            Button("Forward", systemImage: AppIcons.forward) {
                
            }
            Button("Copy", systemImage: AppIcons.copy) {
                
            }
            
            Button("Info", systemImage: AppIcons.info) {
                
            }
            
            Button("Star", systemImage: AppIcons.star) {
                
            }
            
            Button("Pin", systemImage: AppIcons.pin) {
                
            }
            
            Button("Translate", systemImage: AppIcons.translate) {
                
            }
            
            Button("Delete", systemImage: AppIcons.trash, role: .destructive) {
                
            }
        }

    }
    
    var bubbleBackground: Color {
        return model.isCurrentUser ? AppColors.accentDeemphasized : AppColors.background
    }
}

struct BubbleShape: Shape {
    
    let myMessage: Bool
    let showsTail: Bool
    
    func path(in rect: CGRect) -> Path {
        if showsTail {
            return tailedPath(in: rect)
        } else {
            return roundedPath(in: rect)
        }
    }
    
    private func roundedPath(in rect: CGRect) -> Path {
        Path(
            UIBezierPath(
                roundedRect: rect,
                cornerRadius: AppRadius.messageBubble
            ).cgPath
        )
    }
    
    private func tailedPath(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        let bezierPath = UIBezierPath()
        
        if !myMessage {
            bezierPath.move(to: CGPoint(x: 20, y: height))
            bezierPath.addLine(to: CGPoint(x: width - 15, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height - 15), controlPoint1: CGPoint(x: width - 8, y: height), controlPoint2: CGPoint(x: width, y: height - 8))
            bezierPath.addLine(to: CGPoint(x: width, y: 15))
            bezierPath.addCurve(to: CGPoint(x: width - 15, y: 0), controlPoint1: CGPoint(x: width, y: 8), controlPoint2: CGPoint(x: width - 8, y: 0))
            bezierPath.addLine(to: CGPoint(x: 20, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 5, y: 15), controlPoint1: CGPoint(x: 12, y: 0), controlPoint2: CGPoint(x: 5, y: 8))
            bezierPath.addLine(to: CGPoint(x: 5, y: height - 10))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 5, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: CGPoint(x: -1, y: height))
            bezierPath.addCurve(to: CGPoint(x: 12, y: height - 4), controlPoint1: CGPoint(x: 4, y: height + 1), controlPoint2: CGPoint(x: 8, y: height - 1))
            bezierPath.addCurve(to: CGPoint(x: 20, y: height), controlPoint1: CGPoint(x: 15, y: height), controlPoint2: CGPoint(x: 20, y: height))
        } else {
            bezierPath.move(to: CGPoint(x: width - 20, y: height))
            bezierPath.addLine(to: CGPoint(x: 15, y: height))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height - 15), controlPoint1: CGPoint(x: 8, y: height), controlPoint2: CGPoint(x: 0, y: height - 8))
            bezierPath.addLine(to: CGPoint(x: 0, y: 15))
            bezierPath.addCurve(to: CGPoint(x: 15, y: 0), controlPoint1: CGPoint(x: 0, y: 8), controlPoint2: CGPoint(x: 8, y: 0))
            bezierPath.addLine(to: CGPoint(x: width - 20, y: 0))
            bezierPath.addCurve(to: CGPoint(x: width - 5, y: 15), controlPoint1: CGPoint(x: width - 12, y: 0), controlPoint2: CGPoint(x: width - 5, y: 8))
            bezierPath.addLine(to: CGPoint(x: width - 5, y: height - 12))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 5, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
            bezierPath.addLine(to: CGPoint(x: width + 1, y: height))
            bezierPath.addCurve(to: CGPoint(x: width - 12, y: height - 4), controlPoint1: CGPoint(x: width - 4, y: height + 1), controlPoint2: CGPoint(x: width - 8, y: height - 1))
            bezierPath.addCurve(to: CGPoint(x: width - 20, y: height), controlPoint1: CGPoint(x: width - 15, y: height), controlPoint2: CGPoint(x: width - 20, y: height))
        }
        
        return Path(bezierPath.cgPath)
    }
}
