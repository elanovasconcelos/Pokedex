//
//  PokemonListResponseJSON.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import Foundation

struct PokemonListResponseJSON: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonJSON]
}
