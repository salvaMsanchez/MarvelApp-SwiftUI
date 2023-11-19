//
//  SerieTests.swift
//  MarvelApp-SwiftUITests
//
//  Created by Salva Moreno on 19/11/23.
//

import XCTest

@testable import MarvelApp_SwiftUI

final class SerieTests: XCTestCase {
    func testSerieInitialization() {
        let serieId = 16450
        let serieTitle = "A+X (2012 - 2014)"
        let serieDescription = "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?"
        let seriePath = "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34"
        let serieExtension = "jpg"
        let serieThumbnail = SerieThumbnail(path: seriePath, thumbnailExtension: serieExtension)
        
        let serie: Serie = .init(id: serieId, title: serieTitle, description: serieDescription, thumbnail: serieThumbnail)
        XCTAssertNotNil(serie)
        
        XCTAssertEqual(serie.id, serieId)
        XCTAssertEqual(serie.title, serieTitle)
        XCTAssertEqual(serie.description, serieDescription)
        XCTAssertEqual(serie.thumbnail.path, seriePath)
        XCTAssertEqual(serie.thumbnail.thumbnailExtension, serieExtension)
    }
    
    func testSerieResultsInitialization() {
        let serieId = 16450
        let serieTitle = "A+X (2012 - 2014)"
        let serieDescription = "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?"
        let seriePath = "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34"
        let serieExtension = "jpg"
        let serieThumbnail = SerieThumbnail(path: seriePath, thumbnailExtension: serieExtension)
        
        let serie = Serie(id: serieId, title: serieTitle, description: serieDescription, thumbnail: serieThumbnail)
        XCTAssertNotNil(serie)
        
        let jsonData = """
            {
                "data": {
                    "results": [
                        {
                            "id": 16450,
                            "title": "A+X (2012 - 2014)",
                            "description": "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?",
                            "resourceURI": "http://gateway.marvel.com/v1/public/series/16450",
                            "urls": [
                              {
                                "type": "detail",
                                "url": "http://marvel.com/comics/series/16450/ax_2012_-_2014?utm_campaign=apiRef&utm_source=4837bc10899562b5f7ebc30e1656c4b9"
                              }
                            ],
                            "startYear": 2012,
                            "endYear": 2014,
                            "rating": "",
                            "type": "",
                            "modified": "2023-06-06T05:11:16-0400",
                            "thumbnail": {
                              "path": "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34",
                              "extension": "jpg"
                            }
                        }
                    ]
                }
            }
        """.data(using: .utf8)!
        
        do {
            let serieResults = try JSONDecoder().decode(SerieResults.self, from: jsonData)
            XCTAssertNotNil(serieResults.series)
            
            XCTAssertEqual(serieResults.series.count, 1)
            XCTAssertEqual(serieResults.series.first?.id, serieId)
            XCTAssertEqual(serieResults.series.first?.title, serieTitle)
            XCTAssertEqual(serieResults.series.first?.description, serieDescription)
            XCTAssertEqual(serieResults.series.first?.thumbnail.path, seriePath)
            XCTAssertEqual(serieResults.series.first?.thumbnail.thumbnailExtension, serieExtension)
        } catch {
            XCTFail("Error decoding CharacterResults: \(error)")
        }
    }
}
