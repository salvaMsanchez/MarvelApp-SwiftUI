//
//  DataPersistanceManager.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 17/11/23.
//

import Foundation
import CoreData

// MARK: - Protocol -
protocol DataPersistanceManagerProtocol {
    func saveCharacter(characters: Characters, completion: @escaping (Result<Void, DataBaseError>) -> Void)
    func fetchingCharacters(completion: @escaping (Result<Characters, DataBaseError>) -> Void)
}

// MARK: - DataBaseError -
enum DataBaseError: Error {
    case failedToSaveData
    case failedToFetchCharacters
}

// MARK: - DataPersistanceManager -
final class DataPersistanceManager: DataPersistanceManagerProtocol {
    // MARK: - Functions -
    func saveCharacter(characters: Characters, completion: @escaping (Result<Void, DataBaseError>) -> Void) {
        let context = PersistenceController.shared.container.viewContext
        
        characters.forEach { character in
            let item = CharacterDAO(context: context)
            
            item.id = Int64(character.id)
            item.name = character.name
            item.characterDescription = character.description
            item.thumbnail = character.thumbnail.path + character.thumbnail.thumbnailExtension.rawValue
            if let characterFavorite = character.favorite {
                item.favorite = characterFavorite
            }
            
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(.failedToSaveData))
            }
        }
    }
    
    func fetchingCharacters(completion: @escaping (Result<Characters, DataBaseError>) -> Void) {
        let context = PersistenceController.shared.container.viewContext
        
        let request: NSFetchRequest<CharacterDAO>
        request = CharacterDAO.fetchRequest()
        
        do {
            let charactersDAO = try context.fetch(request)
            let characters: Characters = charactersDAO.compactMap { CharacterMapper.mapCharacterDAOToCharacter($0) }
            completion(.success(characters))
        } catch {
            completion(.failure(.failedToFetchCharacters))
        }
    }
}
