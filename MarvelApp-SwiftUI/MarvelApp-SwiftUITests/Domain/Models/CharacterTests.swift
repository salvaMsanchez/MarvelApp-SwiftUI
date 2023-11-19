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
    
    func testCharacterResultsInitialization() {
        let characterId = 1009368
        let characterName = "Iron Man"
        let characterDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        let characterPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        let characterExtension = Extension.jpg
        let characterThumbnail = CharacterThumbnail(path: characterPath, thumbnailExtension: characterExtension)
        
        let character = Character(id: characterId, name: characterName, description: characterDescription, thumbnail: characterThumbnail, favorite: false)
        XCTAssertNotNil(character)
        
        let characters: Characters = [character]
        XCTAssertNotNil(characters)
        
        let characterResults: CharacterResults = try! CharacterResults(from: characters as! Decoder)
        XCTAssertNotNil(characterResults)
        
        XCTAssertEqual(characterResults.characters.count, 1)
        XCTAssertEqual(characterResults.characters.first?.id, characterId)
        XCTAssertEqual(characterResults.characters.first?.name, characterName)
        XCTAssertEqual(characterResults.characters.first?.description, characterDescription)
        XCTAssertEqual(characterResults.characters.first?.thumbnail.path, characterPath)
        XCTAssertEqual(characterResults.characters.first?.thumbnail.thumbnailExtension, characterExtension)
        XCTAssertEqual(characterResults.characters.first?.favorite, false)
    }
}
