//
//  DataPersistanceManagerRepositoryProtocol.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 17/11/23.
//

import Foundation

// MARK: - DataPersistanceManagerRepositoryProtocol -
protocol DataPersistanceManagerRepositoryProtocol {
    func saveCharacter(characters: Characters, completion: @escaping (Result<Void, DataBaseError>) -> Void)
}
