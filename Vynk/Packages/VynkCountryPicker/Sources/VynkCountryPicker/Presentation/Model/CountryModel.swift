//
//  CountryModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

public struct CountryModel: Identifiable, Decodable {
    public let id: Int
    public let name: String
    public let iso2: String
    public let phonecode: String
    public let emoji: String

    public var dialCode: String {
        phonecode.hasPrefix("+") ? phonecode : "+\(phonecode)"
    }
}
