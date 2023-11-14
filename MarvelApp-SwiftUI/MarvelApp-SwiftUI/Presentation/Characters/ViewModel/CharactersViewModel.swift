//
//  CharactersViewModel.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

final class CharactersViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var characters: Characters = []
    
    // MARK: - Use Case -
    let useCase: APIClientUseCaseProtocol
    
    // MARK: - Initializers -
    init(testing: Bool, useCase: APIClientUseCaseProtocol = APIClientUseCase()) {
        self.useCase = useCase
        
        if testing {
            loadCharactersTesting()
        } else {
            // TODO:
//            loadCharacters()
        }
    }
    
    // MARK: - Functions -
    func loadCharactersTesting() {
        Task.init { [weak self] in
            do {
                guard let character = try await self?.useCase.getCharacter(by: "", apiRouter: .getCharacter) else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.characters.append(character)
                }
            } catch {
                print("Testing error: \(error)")
            }
        }
    }
}
