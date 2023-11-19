//
//  CharacterTests.swift
//  MarvelApp-SwiftUITests
//
//  Created by Salva Moreno on 19/11/23.
//

import XCTest

@testable import MarvelApp_SwiftUI

final class CharacterTests: XCTestCase {
    func testCharacterInitialization() {
        let characterId = 1009368
        let characterName = "Iron Man"
        let characterDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        let characterPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        let characterExtension = Extension.jpg
        let characterThumbnail = CharacterThumbnail(path: characterPath, thumbnailExtension: characterExtension)
        
        let character: Character = .init(id: characterId, name: characterName, description: characterDescription, thumbnail: characterThumbnail, favorite: true)
        XCTAssertNotNil(character)
        
        XCTAssertEqual(character.id, characterId)
        XCTAssertEqual(character.name, characterName)
        XCTAssertEqual(character.description, characterDescription)
        XCTAssertEqual(character.thumbnail.path, characterPath)
        XCTAssertEqual(character.thumbnail.thumbnailExtension, characterExtension)
        XCTAssertEqual(character.favorite, true)
    }
    
    func testCharacterResultsInitialization() throws {
        let characterId = 1009368
        let characterName = "Iron Man"
        let characterDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        let characterPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        let characterExtension = Extension.jpg
        let characterThumbnail = CharacterThumbnail(path: characterPath, thumbnailExtension: characterExtension)
        
        let character: Character = .init(id: characterId, name: characterName, description: characterDescription, thumbnail: characterThumbnail, favorite: true)
        XCTAssertNotNil(character)
        
        let jsonData = """
            {
                "data": {
                    "results": [
                        {
                            "id": 1009368,
                            "name": "Iron Man",
                            "description": "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.",
                            "modified": "2016-09-28T12:08:19-0400",
                            "thumbnail": {
                              "path": "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55",
                              "extension": "jpg"
                            }
                        }
                    ]
                }
            }
        """.data(using: .utf8)!
        
        do {
            let characterResults = try JSONDecoder().decode(CharacterResults.self, from: jsonData)
            XCTAssertNotNil(characterResults.characters)
            
            XCTAssertEqual(characterResults.characters.count, 1)
            XCTAssertEqual(characterResults.characters.first?.id, characterId)
            XCTAssertEqual(characterResults.characters.first?.name, characterName)
            XCTAssertEqual(characterResults.characters.first?.description, characterDescription)
            XCTAssertEqual(characterResults.characters.first?.thumbnail.path, characterPath)
            XCTAssertEqual(characterResults.characters.first?.thumbnail.thumbnailExtension, characterExtension)
            XCTAssertEqual(characterResults.characters.first?.favorite, nil)
        } catch {
            XCTFail("Error decoding CharacterResults: \(error)")
        }
    }
}
