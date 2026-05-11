//
//  APIClient.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type)async throws->T
}
