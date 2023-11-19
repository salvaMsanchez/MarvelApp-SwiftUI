//
//  APIClientUseCaseTests.swift
//  MarvelApp-SwiftUITests
//
//  Created by Salva Moreno on 19/11/23.
//

import XCTest

@testable import MarvelApp_SwiftUI

final class APIClientUseCaseTests: XCTestCase {
    func testAPIClientUseCase_realCall_whereWeReceiveACharacterByName() {
        let characterId = 1009368
        let characterName = "Iron Man"
        let characterDescription = "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man."
        let characterPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55"
        let characterExtension = Extension.jpg
        let characterThumbnail = CharacterThumbnail(path: characterPath, thumbnailExtension: characterExtension)
        
        let character: Character = .init(id: characterId, name: characterName, description: characterDescription, thumbnail: characterThumbnail, favorite: true)
        XCTAssertNotNil(character)
        
        let useCase: APIClientUseCaseProtocol = APIClientUseCase()
        
        Task.init {
            let characterCalled = try await useCase.getCharacter(by: characterName, apiRouter: .getCharacter)
            XCTAssertNotNil(characterCalled)
            
            XCTAssertEqual(characterCalled.id, characterId)
            XCTAssertEqual(characterCalled.name, characterName)
            XCTAssertEqual(characterCalled.description, characterDescription)
            XCTAssertEqual(characterCalled.thumbnail.path, characterPath)
            XCTAssertEqual(characterCalled.thumbnail.thumbnailExtension, characterExtension)
            XCTAssertEqual(characterCalled.favorite, true)
        }
    }
    
    func testAPIClientUseCase_realCall_whereWeReceiveAnArrayOfSeriesByCharacterdId() {
        let characterId = 1009368
        
        let serieId = 16450
        let serieTitle = "A+X (2012 - 2014)"
        let serieDescription = "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?"
        let seriePath = "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34"
        let serieExtension = "jpg"
        let serieThumbnail = SerieThumbnail(path: seriePath, thumbnailExtension: serieExtension)
        
        let serie: Serie = .init(id: serieId, title: serieTitle, description: serieDescription, thumbnail: serieThumbnail)
        XCTAssertNotNil(serie)
        
        let useCase: APIClientUseCaseProtocol = APIClientUseCase()
        
        Task.init {
            let seriesCalled = try await useCase.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId))
            XCTAssertNotNil(seriesCalled)
            let seriesFiltered = seriesCalled.filter { $0.description != nil }
            XCTAssertNotNil(seriesFiltered)
            
            XCTAssertEqual(seriesFiltered.first?.id, serieId)
            XCTAssertEqual(seriesFiltered.first?.title, serieTitle)
            XCTAssertEqual(seriesFiltered.first?.description, serieDescription)
            XCTAssertEqual(seriesFiltered.first?.thumbnail.path, seriePath)
            XCTAssertEqual(seriesFiltered.first?.thumbnail.thumbnailExtension, serieExtension)
        }
    }
}
