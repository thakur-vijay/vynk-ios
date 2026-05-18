//
//  URLSessionAPIClient.swift
//  Vynk
//
//  Created by Vijay Thakur on 11/05/26.
//

import Foundation

final class URLSessionAPIClient: APIClient {
    private let configuration: NetworkConfiguration
    private let session: URLSession
    
    init(configuration: NetworkConfiguration, session: URLSession = .shared) {
        self.configuration = configuration
        self.session = session
    }
    
    func request<T>(_ endpoint: any Endpoint, as type: T.Type) async throws -> T where T : Decodable {
        let request = try makeRequest(from: endpoint)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200...299).contains(response.statusCode) else {
                throw NetworkError.serverError(statusCode: response.statusCode, data: data)
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            }catch {
                throw NetworkError.decodingFailed(error)
            }
        }catch let error as NetworkError {
            throw error
        }catch {
            throw NetworkError.underlying(error)
        }
    }
    
    private func makeRequest(from endpoint: Endpoint)throws->URLRequest {
        var components = URLComponents(url: configuration.baseURL.appending(path: endpoint.path), resolvingAgainstBaseURL: false)
        if !endpoint.queryItems.isEmpty {
            components?.queryItems = endpoint.queryItems
        }
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
