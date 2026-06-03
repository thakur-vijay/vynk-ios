//
//  ContactRecord.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation
import GRDB

struct ContactRecord: Codable, FetchableRecord, PersistableRecord{
    
    static let databaseTableName: String = "device_contacts"

    let id: String

    let fullName: String

    let phoneNumbersJSON: Data

    let normalizedPrimaryPhone: String

    let thumbnailImageData: Data?
    
    enum CodingKeys: String, CodingKey {

           case id

           case fullName = "full_name"

           case phoneNumbersJSON = "phone_numbers_json"

           case normalizedPrimaryPhone = "normalized_primary_phone"

           case thumbnailImageData = "thumbnail_image_data"

       }

}

extension ContactRecord {
    nonisolated  enum Columns {

        static let id = Column("id")

        static let fullName = Column("full_name")

        static let phoneNumbersJSON = Column("phone_numbers_json")

        static let normalizedPrimaryPhone = Column("normalized_primary_phone")

        static let thumbnailImageData = Column("thumbnail_image_data")

    }

}
