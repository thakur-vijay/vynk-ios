//
//  FrequentlyContactedSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct FrequentlyContactedSection: View {
    let contacts: [VynkContactModel]
    var body: some View {
        Section {
            ForEach(contacts) { contact in
                VynkContactRow(model: contact)
                    .listRowInsets(.vertical, 0)
            }
        } header: {
            Text("Frequently Contacted")
        }
    }
}
