//
//  DefaultAPI.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import Foundation

protocol API {
    func fetch(page: Int, limit: Int) async throws -> PokemonListResponseJSON
    func fetchDetail(name: String) async throws -> PokemonDetailJSON
    func toggleFavorite(_ pokemon: Pokemon) async throws -> EmptyJSON
}

enum APIError: Error, LocalizedError {
    case name, page, limit
    
    var errorDescription: String? {
        switch self {
        case .name:
            return NSLocalizedString("Invalid or missing name parameter.", comment: "")
        case .page:
            return NSLocalizedString("Invalid or missing page parameter. Please provide a valid page number.", comment: "")
        case .limit:
            return NSLocalizedString("Invalid or missing limit parameter. Please provide a valid limit value.", comment: "")
        }
    }
}

final class DefaultAPI: API {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = APIService()) {
        self.networkService = networkService
    }
    
    func fetch(page: Int = 0, limit: Int = 10) async throws -> PokemonListResponseJSON {
        guard page >= 0 else { throw APIError.page }
        guard limit >= 1 else { throw APIError.limit }
        
        let parameters = ["offset": String(page * limit), "limit": String(limit)]
        
        return try await networkService.request(endpoint: "pokemon", method: .get, parameters: parameters, body: nil)
    }
    
    func fetchDetail(name: String) async throws -> PokemonDetailJSON {
        guard !name.isEmpty else { throw APIError.name }
        
        return try await networkService.request(endpoint: "pokemon/\(name)", method: .get, parameters: nil, body: nil)
    }
    
    func toggleFavorite(_ pokemon: Pokemon) async throws -> EmptyJSON {
        let body = try JSONEncoder().encode(pokemon)
        
        return try await networkService.request(url: "https://webhook.site/a49767a1-5da9-4783-82a2-624951394afe", method: .post, parameters: nil, body: body)
    }
}
