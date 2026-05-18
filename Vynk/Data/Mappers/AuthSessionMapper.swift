//
//  AuthSessionMapper.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

struct AuthSessionMapper {
    static func map(from dto: LoginResponseDTO)-> AuthSession {
        AuthSession(token: dto.token)
    }
}
