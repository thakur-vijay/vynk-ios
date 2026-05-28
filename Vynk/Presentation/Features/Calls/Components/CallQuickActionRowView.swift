//
//  CallQuickActionRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import SwiftUI

struct CallQuickActionRowView: View {
    var body: some View {
        HStack {
            CallQuickActionView(icon: AppIcons.phone, label: "Call") {
                
            }
            
            CallQuickActionView(icon: AppIcons.calendar, label: "Schedule") {
                
            }
            
            CallQuickActionView(icon: AppIcons.calendar, label: "Keypad") {
                
            }
            
            CallQuickActionView(icon: AppIcons.heart, label: "Favourites") {
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CallQuickActionRowView()
}
