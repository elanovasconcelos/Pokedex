//
//  Pokemon+Helper.swift
//  PokedexTests
//
//  Created by Elano Vasconcelos on 04/02/24.
//

import Foundation
@testable import Pokedex

extension Pokemon {
    static let bubasaur = Pokemon(name: "bulbasaur",
                                  baseExperience: 64,
                                  height: 7,
                                  order: 1,
                                  weight: 2,
                                  imageUrl: "imageUrl.com",
                                  spriteUrl: "spriteUrl.com",
                                  abilities: ["a", "b"],
                                  types: ["c"])
    
    static let charmander = Pokemon(name: "charmander",
                                  baseExperience: 10,
                                  height: 8,
                                  order: 3,
                                  weight: 4,
                                  imageUrl: "imageUrl2.com",
                                  spriteUrl: "spriteUrl2.com",
                                  abilities: ["d"],
                                  types: ["abc", "qwe"])
}
