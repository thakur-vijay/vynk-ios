//
//  ContactSectionModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

struct ContactSectionModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let contacts: [DeviceContact]
}
