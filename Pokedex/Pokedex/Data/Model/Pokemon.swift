//
//  Pokemon.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import Foundation

struct Pokemon: Encodable {
    let name: String
    let baseExperience: Int
    let height: Int
    let order: Int
    let weight: Int
    let imageUrl: String
    let spriteUrl: String
    let abilities: [String]
    let types: [String]
}

extension Pokemon: Identifiable {
    var id: Int {
        order
    }
}

extension Pokemon {
    init(detail: PokemonDetailJSON) {
        name = detail.name
        baseExperience = detail.baseExperience
        height = detail.height
        order = detail.order
        weight = detail.weight
        imageUrl = detail.sprites.other?.officialArtwork?.frontDefault ?? ""
        spriteUrl = detail.sprites.frontDefault ?? ""
        abilities = detail.abilities.map{ $0.ability.name }
        types = detail.types.map{ $0.type.name }
    }
}
