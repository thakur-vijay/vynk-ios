//
//  AuthRepository.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

protocol AuthRepository {
    func login()async throws->AuthSession
}
