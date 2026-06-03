//
//  ContactRecordMapper.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation

enum ContactRecordMapper {

    nonisolated static func toRecord(
        _ entity: DeviceContact
    ) -> ContactRecord {

        let phoneNumbersData = try? JSONEncoder()
            .encode(entity.phoneNumbers)

        return ContactRecord(
            id: entity.id,
            fullName: entity.fullName,
            phoneNumbersJSON: phoneNumbersData ?? .init(),
            normalizedPrimaryPhone: normalizePhoneNumber(
                entity.phoneNumbers.first ?? ""
            ),
            thumbnailImageData: entity.thumbnailImageData
        )
    }

    nonisolated static func toEntity(
        _ record: ContactRecord
    ) -> DeviceContact {

        let phoneNumbers = (
            try? JSONDecoder().decode(
                [String].self,
                from: record.phoneNumbersJSON
            )
        ) ?? []

        return DeviceContact(
            id: record.id,
            givenName: "",
            familyName: "",
            fullName: record.fullName,
            phoneNumbers: phoneNumbers,
            thumbnailImageData: record.thumbnailImageData
        )
    }

    nonisolated private static func normalizePhoneNumber(
        _ phoneNumber: String
    ) -> String {

        let digits = phoneNumber.filter(\.isNumber)

        if digits.count > 10 {
            return String(digits.suffix(10))
        }

        return digits
    }
}
