//
//  CountryModel.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import Foundation

public struct CountryModel: Identifiable, Decodable, Equatable, Sendable{
    public let id: Int
    public let name: String
    public let iso2: String
    public let phonecode: String
    public let emoji: String
    
    public init(id: Int, name: String, iso2: String, phonecode: String, emoji: String) {
        self.id = id
        self.name = name
        self.iso2 = iso2
        self.phonecode = phonecode
        self.emoji = emoji
    }

    public var dialCode: String {
        phonecode.hasPrefix("+") ? phonecode : "+\(phonecode)"
    }
}
