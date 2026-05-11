//
//  NetworkError.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingFailed(Error)
    case serverError(statusCode: Int, data: Data?)
    case underlying(Error)
}
