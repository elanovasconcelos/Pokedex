//
//  AbilityEntryJSON.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import Foundation

struct AbilitiesJSON: Decodable {
    let isHidden: Bool
    let slot: Int
    let ability: AbilityJSON
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot
        case ability
    }
}

struct AbilityJSON: Decodable {
    let name: String
    let url: String
}
