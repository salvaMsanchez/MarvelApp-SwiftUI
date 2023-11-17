//
//  DataPersistanceManagerUseCase.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 17/11/23.
//

import Foundation

// MARK: - DataPersistanceManagerUseCaseProtocol -
protocol DataPersistanceManagerUseCaseProtocol {
    var repository: DataPersistanceManagerRepositoryProtocol { get set }
    func saveCharacter(characters: Characters, completion: @escaping (Result<Void, DataBaseError>) -> Void)
    func fetchingCharacters(completion: @escaping (Result<Characters, DataBaseError>) -> Void)
}

// MARK: - DataPersistanceManagerUseCase -
final class DataPersistanceManagerUseCase: DataPersistanceManagerUseCaseProtocol {
    // MARK: - Properties -
    var repository: DataPersistanceManagerRepositoryProtocol
    
    // MARK: - Initializers -
    init(repository: DataPersistanceManagerRepositoryProtocol = DataPersistanceManagerRepository()) {
        self.repository = repository
    }
    
    // MARK: - Functions -
    func saveCharacter(characters: Characters, completion: @escaping (Result<Void, DataBaseError>) -> Void) {
        repository.saveCharacter(characters: characters, completion: completion)
    }
    
    func fetchingCharacters(completion: @escaping (Result<Characters, DataBaseError>) -> Void) {
        repository.fetchingCharacters(completion: completion)
    }
}
