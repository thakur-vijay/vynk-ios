//
//  FetchDeviceContactsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

final class FetchDeviceContactsUseCase {
    private let repository: ContactsRepository
    
    init(repository: ContactsRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [DeviceContact] {
           let contacts = try await repository.fetchContacts()

           let contactsWithPhoneNumbers = contacts.filter {
               !$0.phoneNumbers.isEmpty
           }
        
           let uniqueContacts = Dictionary(
               contactsWithPhoneNumbers.map { contact in
                   let primaryPhoneNumber = normalizePhoneNumber(
                       contact.phoneNumbers.first ?? ""
                   )
                   
                   return (
                       primaryPhoneNumber,
                       contact
                   )
               },
               uniquingKeysWith: { first, _ in
                   first
               }
           )
           .values
        
           return uniqueContacts.sorted {
               $0.fullName.localizedCaseInsensitiveCompare(
                   $1.fullName
               ) == .orderedAscending
           }
       }

       private func normalizePhoneNumber(
           _ phoneNumber: String
       ) -> String {
           let digits = phoneNumber.filter(\.isNumber)
           if digits.count > 10 {
               return String(digits.suffix(10))
           }
           return digits

       }
    
}
