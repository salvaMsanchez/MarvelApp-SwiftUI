//
//  CharactersViewModelTests.swift
//  MarvelApp-SwiftUITests
//
//  Created by Salva Moreno on 19/11/23.
//

import XCTest

@testable import MarvelApp_SwiftUI

final class CharactersViewModelTests: XCTestCase {
    private var sut: CharactersViewModel!
    
    override func setUp() {
        sut = CharactersViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess(), coreDataUseCase: DataPersistanceManagerUseCase())
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelInitialization_withAPIClientFakeSuccess() {
        XCTAssertNotNil(sut)
        
        let expectation = XCTestExpectation(description: "Characters saved from APIClient")
        
        let statusObserver = sut.$status.sink { status in
            if status == .loaded {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertNotNil(sut.characters)
        XCTAssertEqual(sut.characters.count, 5)
    }
    
    func testFetchingCharactersFromCoreData() {
        XCTAssertNotNil(sut)
        
        let expectation = XCTestExpectation(description: "Characters saved from APIClient")
        
        let statusObserver = sut.$status.sink { status in
            if status == .loaded {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
        let characters: Characters = sut.fetchingCharactersCoreData()
        XCTAssertNotNil(characters)
        
        XCTAssertEqual(characters.last?.name, sut.characters.last?.name)
    }
}
