//
//  APIService.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(endpoint: String, method: HttpMethod, parameters: [String: Any]?, body: Data?) async throws -> T
    func request<T: Decodable>(url: String, method: HttpMethod, parameters: [String: Any]?, body: Data?) async throws -> T
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkServiceError: Error, LocalizedError {
    case url
    
    var errorDescription: String? {
        switch self {
        case .url:
            return NSLocalizedString("Invalid URL", comment: "")
        }
    }
}

final class APIService: NetworkService {
    
    private let baseURL: String

    init(baseURL: String = "https://pokeapi.co/api/v2/") {
        self.baseURL = baseURL
    }
    
    func request<T: Decodable>(endpoint: String, method: HttpMethod, parameters: [String: Any]? = nil, body: Data? = nil) async throws -> T {
        let url = "\(baseURL)/\(endpoint)"
        
        return try await request(url: url, method: method, parameters: parameters, body: body)
    }
    
    func request<T: Decodable>(url: String, method: HttpMethod, parameters: [String: Any]? = nil, body: Data? = nil) async throws -> T {
        var component = URLComponents(string: url)
        
        if method == .get, let parameters = parameters {
            component?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = component?.url else {
            throw NetworkServiceError.url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .returnCacheDataElseLoad
        
        if method == .post, let body = body {
            request.httpBody = body
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        return decodedResponse
    }
}
