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
            CallQuickActionView(icon: AppSymbols.phone.name, label: "Call") {
                
            }
            
            CallQuickActionView(icon: AppSymbols.calendar.name, label: "Schedule") {
                
            }
            
            CallQuickActionView(icon: AppSymbols.calendar.name, label: "Keypad") {
                
            }
            
            CallQuickActionView(icon: AppSymbols.heart.name, label: "Favourites") {
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CallQuickActionRowView()
}
