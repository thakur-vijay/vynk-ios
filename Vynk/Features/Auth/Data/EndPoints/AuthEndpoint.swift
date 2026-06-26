//
//  AuthEndpoint.swift
//  Vynk
//
//  Created by Vijay Thakur on 18/05/26.
//

import Foundation

enum AuthEndpoint: Endpoint {
    case login
    
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    
}
