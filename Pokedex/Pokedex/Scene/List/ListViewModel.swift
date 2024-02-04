//
//  ListViewModel.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import SwiftUI

extension ListView {
    
    final class ViewModel: ObservableObject {
        
        enum ActionType {
            case selection(Pokemon)
        }
        
        private let repository: Repository
        private let completion: (ActionType) -> Void
        private var currentPage = 0
        private var canLoadMore = true
        private var isLoading = false
        
        @Published var pokemons: [Pokemon] = []
        
        init(repository: Repository = PokemonRepository(), 
             completion: @escaping (ActionType) -> Void = { _ in }) {
            self.repository = repository
            self.completion = completion
        }
        
        func onAppear() async {
            guard pokemons.isEmpty else { return }
            
            await fetchPokemons()
        }
        
        func tryLoadNextPage(currentPokemon: Pokemon) async {
            guard !isLoading, pokemons.count >= 10 else { return }
            
            if pokemons[pokemons.count - 5].id == currentPokemon.id {
                await fetchPokemons()
            }
        }
        
        func didSelect(pokemon: Pokemon) {
            completion(.selection(pokemon))
        }
    }
}

private extension ListView.ViewModel {
    @MainActor
    func fetchPokemons() async {
        guard canLoadMore, !isLoading else { return }
        
        isLoading = true
        print("fetchPokemons")
        
        let result = await repository.fechPokemonList(page: currentPage)
        
        switch result {
        case .success(let newPokemons):
            if newPokemons.isEmpty {
                canLoadMore = false
            } else {
                pokemons.append(contentsOf: newPokemons)
                currentPage += 1
            }
        case .failure(let failure):
            print("error: \(failure.localizedDescription)")
            canLoadMore = false
        }
        
        isLoading = false
    }
}
