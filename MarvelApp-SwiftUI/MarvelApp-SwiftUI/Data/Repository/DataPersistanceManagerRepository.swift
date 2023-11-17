//
//  DataPersistanceManagerRepository.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 17/11/23.
//

import Foundation

// MARK: - DataPersistanceManagerRepository -
final class DataPersistanceManagerRepository: DataPersistanceManagerRepositoryProtocol {
    // MARK: - Properties -
    private var dataPersistanceManager: DataPersistanceManagerProtocol
    
    // MARK: - Initializers -
    init(dataPersistanceManager: DataPersistanceManagerProtocol = DataPersistanceManager()) {
        self.dataPersistanceManager = dataPersistanceManager
    }
    
    // MARK: - Functions -
    func saveCharacter(characters: Characters, completion: @escaping (Result<Void, DataBaseError>) -> Void) {
        dataPersistanceManager.saveCharacter(characters: characters, completion: completion)
    }
    
    func fetchingCharacters(completion: @escaping (Result<Characters, DataBaseError>) -> Void) {
        dataPersistanceManager.fetchingCharacters(completion: completion)
    }
}
