//
//  FetchPermissionStatusUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

final class FetchPermissionStatusUseCase {
    private let repository: ContactsRepository
    init(repository: ContactsRepository) {
        self.repository = repository
    }
    
    func execute()-> ContactsPermissionStatus {
        return repository.permissionStatus()
    }
}
