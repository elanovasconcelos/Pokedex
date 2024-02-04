//
//  OtherSpritesJSON.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import Foundation

struct OtherSpritesJSON: Decodable {
    let dreamWorld: DreamWorldSpritesJSON?
    let home: HomeSpritesJSON?
    let officialArtwork: OfficialArtworkSpritesJSON?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
}

struct DreamWorldSpritesJSON: Decodable {
    let frontDefault: String?
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

struct HomeSpritesJSON: Decodable {
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct OfficialArtworkSpritesJSON: Decodable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

