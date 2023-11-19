//
//  CharacterSeriesViewModel.swift
//  MarvelApp-SwiftUITests
//
//  Created by Salva Moreno on 19/11/23.
//

import XCTest

@testable import MarvelApp_SwiftUI

final class CharacterSeriesViewModelTests: XCTestCase {
    private var sut: CharacterSeriesViewModel!
    
    override func setUp() {
        let characterId = 1009368
        let characterName = "Iron Man"
        let characterDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        let characterPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        let characterExtension = Extension.jpg
        let characterThumbnail = CharacterThumbnail(path: characterPath, thumbnailExtension: characterExtension)
        
        let character: Character = .init(id: characterId, name: characterName, description: characterDescription, thumbnail: characterThumbnail, favorite: true)
        XCTAssertNotNil(character)
        
        sut = CharacterSeriesViewModel(testing: true, apiClientUseCase: APIClientUseCaseFakeSuccess(), character: character)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelInitialization_withAPIClientFakeSuccess() {
        XCTAssertNotNil(sut)
        
        let expectation = XCTestExpectation(description: "Series saved from APIClient")
        
        let statusObserver = sut.$status.sink { status in
            if status == .loaded {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertNotNil(sut.series)
        XCTAssertEqual(sut.series.count, 4)
    }
}
