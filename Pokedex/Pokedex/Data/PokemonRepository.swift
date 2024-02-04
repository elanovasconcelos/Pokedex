//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import Foundation

protocol Repository {
    func fechPokemonList(page: Int) async -> Result<[Pokemon], RepositoryError>
}

protocol FavoriteAPI {
    func toggleFavorite(_ pokemon: Pokemon) async
    func isFavorite(_ pokemon: Pokemon) -> Bool
}

enum RepositoryError: Error, LocalizedError {
    case api
    
    var errorDescription: String? {
        switch self {
        case .api:
            return NSLocalizedString("An error occurred while fetching data from the API.", comment: "")
        }
    }
}

final class PokemonRepository: Repository, FavoriteAPI {

    private static var favorites = Set<Int>()
    
    private let api: API
    private let limit = 12
    
    init(api: API = DefaultAPI()) {
        self.api = api
    }
    
    func fechPokemonList(page: Int = 0) async -> Result<[Pokemon], RepositoryError> {
        do {
            let listResult = try await api.fetch(page: page, limit: limit)
            let results = listResult.results
            
            // Concurrently fetch details for all pokemons in the list
            var pokemons = [Pokemon]()
            try await withThrowingTaskGroup(of: Pokemon.self) { group in
                for result in results {
                    group.addTask {
                        let detail = try await self.api.fetchDetail(name: result.name)
                        return Pokemon(detail: detail)
                    }
                }
                
                // Collect fetched pokemons
                for try await pokemon in group {
                    pokemons.append(pokemon)
                }
            }
            
            return .success(pokemons.sorted{ $0.order < $1.order })
        } catch {
            print("fechPokemonList: \(error.localizedDescription)")
            return .failure(.api)
        }
    }
    
    func toggleFavorite(_ pokemon: Pokemon) async {
        do {
            if PokemonRepository.favorites.contains(pokemon.id) {
                PokemonRepository.favorites.remove(pokemon.id)
            } else {
                PokemonRepository.favorites.insert(pokemon.id)
            }
            
             _ = try await api.toggleFavorite(pokemon)
        } catch  {
            print("toggleFavorite: \(error.localizedDescription)")
        }
    }
    
    func isFavorite(_ pokemon: Pokemon) -> Bool {
        PokemonRepository.favorites.contains(pokemon.id)
    }
}
