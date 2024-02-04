//
//  AppFactory.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import SwiftUI

final class AppFactory {
    
    static func list(completion: @escaping (ListView.ViewModel.ActionType) -> Void = { _ in }) -> ListView {
        let viewModel = ListView.ViewModel(completion: completion)
        
        return ListView(viewModel: viewModel)
    }
    
    static func detail(pokemon: Pokemon) -> ListDetailView {
        let viewModel = ListDetailView.ViewModel(pokemon: pokemon)
        
        return ListDetailView(viewModel: viewModel)
    }
}
