//
//  Endpoint.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var body: Data? { get }
}

extension Endpoint {
    var headers: [String: String] { [:] }
    var queryItems: [URLQueryItem] { [] }
    var body: Data? { nil }
}
