//
//  DefaultAPITests.swift
//  PokedexTests
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import XCTest
@testable import Pokedex

final class DefaultAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchRequest() async throws {
        let sut = makeSUT()
        
        let response = try await sut.fetch()
        
        XCTAssertFalse(response.results.isEmpty)
        XCTAssertNotNil(response.next)
        XCTAssertNil(response.previous)
        
        if !response.results.isEmpty {
            XCTAssertNotNil(response.results.first?.name)
            XCTAssertNotNil(response.results.first?.url)
        }
    }

    func testDetailRequest() async throws {
        let sut = makeSUT()
        
        let response = try await sut.fetchDetail(name: "clefairy")
        XCTAssertEqual(response.name, "clefairy")
        XCTAssertNotNil(response.sprites.frontDefault)
        XCTAssertNotNil(response.sprites.other?.officialArtwork?.frontDefault)
    }

    func testFavorite() async throws {
        let sut = makeSUT()
        
        _ = try await sut.toggleFavorite(makePokemon())
    }
}

extension DefaultAPITests {
    func makeSUT() -> DefaultAPI {
        DefaultAPI()
    }
    
    func makePokemon() -> Pokemon {
        Pokemon(name: "name",
                baseExperience: 1,
                height: 2,
                order: 3,
                weight: 4,
                imageUrl: "",
                spriteUrl: "",
                abilities: ["a"],
                types: ["b"])
    }
}
