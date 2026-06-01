//
//  CountryModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

struct CountryModel: Identifiable, Decodable {
    let id: Int
    let name: String
    let iso2: String
    let phonecode: String
    let emoji: String

    var dialCode: String {
        phonecode.hasPrefix("+") ? phonecode : "+\(phonecode)"
    }
}
