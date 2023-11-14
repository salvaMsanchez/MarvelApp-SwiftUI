//
//  APIClientUseCase.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

// MARK: - APIClientUseCaseProtocol -
protocol APIClientUseCaseProtocol {
    var repository: APIClientRepositoryProtocol { get set }
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> Series
}

// MARK: - APIClientUseCase -
final class APIClientUseCase: APIClientUseCaseProtocol {
    // MARK: - Properties -
    var repository: APIClientRepositoryProtocol
    
    // MARK: - Initializers -
    init(repository: APIClientRepositoryProtocol = APIClientRepository()) {
        self.repository = repository
    }
    
    // MARK: - Functions -
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
        try await repository.getCharacter(by: characterName, apiRouter: .getCharacter)
    }
    
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> Series {
        try await repository.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId))
    }
}

//esta clase nos vale para diseño de UI de UIKIt y SwiftUI y Testing.
final class APIClientUseCaseFakeSuccess: APIClientUseCaseProtocol{
    // MARK: - Properties -
    var repository: APIClientRepositoryProtocol
    
    // MARK: - Initializers -
    init(repository: APIClientRepositoryProtocol = APIClientRepository(apiClient: APIClientFakeSuccess())) {
        self.repository = repository
    }
    
    // MARK: - Functions -
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
        try await repository.getCharacter(by: characterName, apiRouter: .getCharacter)
    }
    
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> Series {
        try await repository.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId))
    }
}
