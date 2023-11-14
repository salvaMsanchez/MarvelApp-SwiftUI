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
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> CharacterResults
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> SerieResults
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
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> CharacterResults {
        try await repository.getCharacter(by: characterName, apiRouter: .getCharacter)
    }
    
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> SerieResults {
        try await repository.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId))
    }
}
