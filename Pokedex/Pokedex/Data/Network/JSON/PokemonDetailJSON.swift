//
//  PokemonDetailJSON.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import Foundation

struct PokemonDetailJSON: Decodable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let isDefault: Bool
    let order: Int
    let weight: Int
    let sprites: SpritesJSON
    let abilities: [AbilitiesJSON]
    let types: [TypesJSON]
    enum CodingKeys: String, CodingKey {
        case id, name, height, order, weight, sprites, abilities, types
        case baseExperience = "base_experience"
        case isDefault = "is_default"
    }
}
