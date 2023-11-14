//
//  APIClientRepositoryProtocol.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

// MARK: - APIClientRepositoryProtocol -
protocol APIClientRepositoryProtocol {
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> Series
}
