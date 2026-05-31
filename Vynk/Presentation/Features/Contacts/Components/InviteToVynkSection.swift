//
//  SwiftUIView.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct InviteToVynkSection: View {
    let contacts: [DeviceContact]
    var body: some View {
        Section {
            ForEach(contacts) { contact in
                ContactRowView(model: contact)
                    .listRowInsets(.vertical, 0)
            }
        } header: {
            Text("Invite to Vynk")
        }

    }
}
