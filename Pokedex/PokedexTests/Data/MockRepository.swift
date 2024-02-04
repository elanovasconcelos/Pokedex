//
//  MockRepository.swift
//  PokedexTests
//
//  Created by Elano Vasconcelos on 04/02/24.
//

import Foundation
@testable import Pokedex

final class MockRepository: Repository {
    
    private(set) var callCount = 0
    
    let pokemons: [Pokemon]
    
    init(pokemons: [Pokemon] = []) {
        self.pokemons = pokemons
    }
    
    func fechPokemonList(page: Int) async -> Result<[Pokedex.Pokemon], Pokedex.RepositoryError> {
        callCount += 1
        return .success(pokemons)
    }
    
    
}
