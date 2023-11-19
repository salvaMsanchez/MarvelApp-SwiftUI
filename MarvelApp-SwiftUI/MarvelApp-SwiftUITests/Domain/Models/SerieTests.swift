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
        
        let series: Series = [serie]
        XCTAssertNotNil(series)
        
        let serieResults: SerieResults = try! SerieResults(from: series as! Decoder)
        XCTAssertNotNil(serieResults)
        
        XCTAssertEqual(serieResults.series.count, 1)
        XCTAssertEqual(serieResults.series.first?.id, serieId)
        XCTAssertEqual(serieResults.series.first?.title, serieTitle)
        XCTAssertEqual(serieResults.series.first?.description, serieDescription)
        XCTAssertEqual(serieResults.series.first?.thumbnail.path, seriePath)
        XCTAssertEqual(serieResults.series.first?.thumbnail.thumbnailExtension, serieExtension)
    }
}
