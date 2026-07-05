//
//  SwiftUIView.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct InviteToVynkSection: View {
    let contacts: [DeviceContact]
    let onInviteTap: (DeviceContact)->()
    var body: some View {
        Section {
            ForEach(contacts) { contact in
                DeviceContactRow(model: contact, onInviteTap: onInviteTap)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        } header: {
            Text("Invite to Vynk")
        }

    }
}
