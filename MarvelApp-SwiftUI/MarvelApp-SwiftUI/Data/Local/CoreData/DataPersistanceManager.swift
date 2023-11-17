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
}

// MARK: - DataBaseError -
enum DataBaseError: Error {
    case failedToSaveData
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
}
