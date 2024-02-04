//
//  ListDetailViewModelTests.swift
//  PokedexTests
//
//  Created by Elano Vasconcelos on 04/02/24.
//

import XCTest
@testable import Pokedex

final class ListDetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelValues() throws {
        let sut = ListDetailView.ViewModel(pokemon: .bubasaur)
        
        XCTAssertEqual(sut.title, "Bulbasaur #001")
        XCTAssertEqual(sut.abilities, "Abilities: a, b")
        XCTAssertEqual(sut.favoriteColor, .gray)
    }

    

}
