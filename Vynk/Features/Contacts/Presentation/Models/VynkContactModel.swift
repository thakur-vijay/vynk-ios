//
//  VynkContactModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

struct VynkContactModel: Identifiable {
    let id: String = UUID().uuidString
    
    let avatar: String?
    
    let name: String?
    
    let about: String?
}
