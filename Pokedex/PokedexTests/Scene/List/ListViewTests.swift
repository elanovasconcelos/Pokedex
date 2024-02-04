//
//  ListViewTests.swift
//  PokedexTests
//
//  Created by Elano Vasconcelos on 03/02/24.
//

import SnapshotTesting
import XCTest
import SwiftUI

@testable import Pokedex

@MainActor
final class ListViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadList_no_items() async throws {
        let sut = await makeSUT()
        
        assertSnapshot(of: sut, as: .image(on: .iPhoneSe))
    }
    
    func testLoadList_one_items() async throws {
        let sut = await makeSUT(pokemons: [.bubasaur])
        
        assertSnapshot(of: sut, as: .image(on: .iPhoneSe))
    }
    
    func testLoadList_two_items() async throws {
        let sut = await makeSUT(pokemons: [.bubasaur, .charmander])
        
        assertSnapshot(of: sut, as: .image(on: .iPhoneSe))
    }
    
    func testLoadList_two_items_ladscape() async throws {
        let sut = await makeSUT(pokemons: [.bubasaur, .charmander])
        
        assertSnapshot(of: sut, as: .image(on: .iPhoneSe(.landscape)))
    }
}

extension ListViewTests {
    func makeViewModel(pokemons: [Pokemon] = []) -> ListView.ViewModel {
        ListView.ViewModel(repository: MockRepository(pokemons: pokemons))
    }
    
    func makeSUT(pokemons: [Pokemon] = []) async -> UIHostingController<ListView> {
        let viewModel = makeViewModel(pokemons: pokemons)
        let listView = ListView(viewModel: viewModel)
        let sut = UIHostingController(rootView: listView)
        
        await viewModel.onAppear()
        
        return sut
    }
}
