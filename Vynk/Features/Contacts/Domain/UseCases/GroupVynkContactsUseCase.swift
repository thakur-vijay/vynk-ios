//
//  GroupVynkContactsUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import Foundation

final class GroupVynkContactsUseCase {
    func execute(
        contacts: [VynkContactModel]
    ) -> [ContactSectionModel]{
        return makeSections(from: contacts)
    }
    
    private func makeSections(
        from contacts: [VynkContactModel]
    ) -> [ContactSectionModel] {
        
        let grouped = Dictionary(grouping: contacts) { contact in
            guard let firstCharacter = contact.name?
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .localizedUppercase
                .first,
                firstCharacter.isLetter
            else {
                return "#"
            }
            
            return String(firstCharacter)
        }
        
        return grouped
            .map { title, contacts in
                ContactSectionModel(
                    title: title,
                    contacts: contacts.sorted {
                        ($0.name ?? "")
                            .localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending
                    }
                )
            }
            .sorted {
                if $0.title == "#" { return false }
                if $1.title == "#" { return true }
                return $0.title < $1.title
            }
    }
}
