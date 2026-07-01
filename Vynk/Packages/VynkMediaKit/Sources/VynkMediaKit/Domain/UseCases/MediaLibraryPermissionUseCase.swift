//
//  MediaLibraryPermissionUseCase.swift
//  Vynk
//
//  Created by Vijay Thakur on 05/06/26.
//

import Foundation

final class MediaLibraryPermissionUseCase {
    private let repository: MediaLibraryRepository
    
    init(repository: MediaLibraryRepository) {
        self.repository = repository
    }
    
    func status()-> MediaLibraryPermissionStatus {
        return repository.permissionStatus()
    }
    
    func request()async throws->MediaLibraryPermissionStatus {
        return try await repository.requestPermission()
    }
}
