//
//  ListDetailViewModel.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import SwiftUI

extension ListDetailView {
    final class ViewModel: ObservableObject {
        
        let navigationTitle = "Details"
        let title: String
        let baseExperience: String
        let height: String
        let weight: String
        let imageUrl: String
        let spriteUrl: String
        let abilities: String
        let type: String
        
        @Published var favoriteImage = ""
        @Published var favoriteColor: Color = .gray
        
        private let avoriteAPI: FavoriteAPI
        private let pokemon: Pokemon
        private var isFavorite: Bool = false {
            didSet {
                updateFavorite()
            }
        }
        
        init(pokemon: Pokemon, favoriteAPI: FavoriteAPI = PokemonRepository()) {
            self.pokemon = pokemon
            self.title = "\(pokemon.name.capitalized) \(String(format: "#%03d", pokemon.order))"
            self.baseExperience = "Base Experience: \(pokemon.baseExperience)"
            self.height = "Height: \(pokemon.height)"
            self.weight = "Weight: \(pokemon.weight)"
            self.imageUrl = pokemon.imageUrl
            self.spriteUrl = pokemon.spriteUrl
            self.abilities = "Abilities: \(pokemon.abilities.joined(separator: ", "))" 
            self.type = "Type: \(pokemon.types.joined(separator: ", "))" 
            
            self.avoriteAPI = favoriteAPI
            self.isFavorite = favoriteAPI.isFavorite(pokemon)
            
            updateFavorite()
        }
        
        @MainActor
        func toggleFavorite() async {
            isFavorite.toggle()
            await avoriteAPI.toggleFavorite(pokemon)
        }
        
        private func updateFavorite() {
            favoriteImage = isFavorite ? "heart.fill": "heart"
            favoriteColor = isFavorite ? .red : .gray
        }
    }
}
