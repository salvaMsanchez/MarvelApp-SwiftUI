//
//  CharactersViewModelTests.swift
//  MarvelApp-SwiftUITests
//
//  Created by Salva Moreno on 19/11/23.
//

import XCTest

@testable import MarvelApp_SwiftUI

final class CharactersViewModelTests: XCTestCase {
    func testUseCaseViewModel_fake() {
        let viewModel: CharactersViewModel = CharactersViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess(), coreDataUseCase: DataPersistanceManagerUseCase())
        XCTAssertNotNil(viewModel)
        
        XCTAssertNotNil(viewModel.characters)
        XCTAssertEqual(viewModel.characters.count, 5)
    }
}
