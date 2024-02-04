//
//  MainCoordinator.swift
//  Pokedex
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import SwiftUI

final class MainCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        openList()
        
        return navigationController
    }
}

private extension MainCoordinator {
    func openList() {
        let view = AppFactory.list { [weak self] type in
            switch type {
            case .selection(let pokemon):
                self?.openDetail(pokemon: pokemon)
            }
        }
        pushView(view, animated: false)
    }
    
    func openDetail(pokemon: Pokemon) {
        let view = AppFactory.detail(pokemon: pokemon)
        
        pushView(view)
    }
    
    func pushView(_ view: some View, animated: Bool = true) {
        navigationController.pushViewController(UIHostingController(rootView: view), animated: true)
    }
}
