//
//  ContactsOnVynkSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct ContactsOnVynkSection: View {
    let contacts: [VynkContactModel]
    var body: some View {
        Section {
            ForEach(contacts) { contact in
                VynkContactRow(model: contact)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        } header: {
            Text("Contacts on Vynk")
        }
    }
}
