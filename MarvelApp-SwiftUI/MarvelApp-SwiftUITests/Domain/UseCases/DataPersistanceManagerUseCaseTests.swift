//
//  DataPersistanceManagerUseCaseTests.swift
//  MarvelApp-SwiftUITests
//
//  Created by Salva Moreno on 19/11/23.
//

import XCTest

@testable import MarvelApp_SwiftUI

final class DataPersistanceManagerUseCaseTests: XCTestCase {
    private var sut: DataPersistanceManagerUseCaseProtocol!
    
    override func setUp() {
        sut = DataPersistanceManagerUseCase()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataPersistanceManagerUseCase_whenSaveCharacter_thenGetStoredCharacter() {
        let characterId = 1009368
        let characterName = "Iron Man"
        let characterDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        let characterPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        let characterExtension = Extension.jpg
        let characterThumbnail = CharacterThumbnail(path: characterPath, thumbnailExtension: characterExtension)
        
        let character: Character = .init(id: characterId, name: characterName, description: characterDescription, thumbnail: characterThumbnail, favorite: true)
        XCTAssertNotNil(character)
        
        let expectation = XCTestExpectation(description: "Save Character in CoreData")
        
        sut.saveCharacter(characters: [character]) { result in
            switch result {
                case .success():
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error saving the character in CoreData: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        sut.fetchingCharacters { result in
            switch result {
                case .success(let characters):
                    let character = characters.first
                    XCTAssertNotNil(character, "The character was not saved in CoreData")
                    XCTAssertEqual(character?.name, "Iron Man")
                case .failure(let error):
                    XCTFail("Error when getting the character: \(error)")
            }
        }
    }
    
    func testDataPersistanceManagerUseCase_whenUpdateFavorite() {
        let characterId = 1009368
        let characterName = "Iron Man"
        let characterDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        let characterPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        let characterExtension = Extension.jpg
        let characterThumbnail = CharacterThumbnail(path: characterPath, thumbnailExtension: characterExtension)
        
        let character: Character = .init(id: characterId, name: characterName, description: characterDescription, thumbnail: characterThumbnail, favorite: true)
        XCTAssertNotNil(character)
        XCTAssertTrue(character.favorite!)
        
        let expectation = XCTestExpectation(description: "Update the favorite parameter in character")
        
        sut.updateFavorite(thisCharacter: character, to: false) { result in
            switch result {
                case .success():
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error updating favorite parameter: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        sut.fetchingCharacters { result in
            switch result {
                case .success(let characters):
                    let character = characters.first
                    XCTAssertNotNil(character, "The character was not saved in CoreData")
                    XCTAssertFalse(character!.favorite!)
                case .failure(let error):
                    XCTFail("Error when getting the character: \(error)")
            }
        }
    }
}
