//
//  ContactRecord.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation
import VynkDatabaseKit

struct ContactRecord: Codable, VynkFetchableRecord, VynkPersistableRecord{
    
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
    enum ColumnNames {
        static let id = VynkColumnName("id")
        static let fullName = VynkColumnName("full_name")
        static let normalizedPrimaryPhone = VynkColumnName("normalized_primary_phone")
    }
}

extension ContactRecord {
    nonisolated  enum Columns {

        static let id = VynkColumn("id")

        static let fullName = VynkColumn("full_name")

        static let phoneNumbersJSON = VynkColumn("phone_numbers_json")

        static let normalizedPrimaryPhone = VynkColumn("normalized_primary_phone")

        static let thumbnailImageData = VynkColumn("thumbnail_image_data")

    }

}
