//
//  TypesJSON.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import Foundation

struct TypesJSON: Decodable {
    let slot: Int
    let type: TypeJSON
}

struct TypeJSON: Decodable {
    let name: String
    let url: String
}
