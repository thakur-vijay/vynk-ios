//
//  ContactsOnVynkSection.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct VynkContactsGroupSection: View {
    let sections: [ContactSectionModel]
    var body: some View {
        ForEach(sections) { section in
            Section {
                ForEach(section.contacts) { contact in
                    VynkContactRow(model: contact)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            } header: {
                Text(section.title)
            }
        }
    }
}
