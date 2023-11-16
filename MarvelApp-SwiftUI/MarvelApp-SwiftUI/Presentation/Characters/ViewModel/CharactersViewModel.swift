//
//  CharactersViewModel.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

let charactersToUse: [String] = ["Iron Man",
                                "Hulk",
                                "Wolverine",
                                "Thor",
                                "Spider-Man (Peter Parker)",
                                "Avengers",
                                "Captain America",
                                "Guardians of the Galaxy",
                                "Wonder Man",
                                "X-Men"]

// MARK: - CharactersViewStatus -
enum CharactersViewStatus {
    case none, loading, loaded, error
}

// MARK: - CharactersViewModel -
final class CharactersViewModel: ObservableObject {
    // MARK: - Properties -
    let listCharacters: [String] = charactersToUse
    @Published var characters: Characters = []
    @Published var favoritesCharacters: Characters = [.init(id: 0, name: "", description: "", thumbnail: .init(path: "", thumbnailExtension: .jpg))]
    @Published var status: CharactersViewStatus = .none
    
    // MARK: - Use Case -
    let useCase: APIClientUseCaseProtocol
    
    // MARK: - Initializers -
    init(testing: Bool = false, useCase: APIClientUseCaseProtocol = APIClientUseCase()) {
        self.useCase = useCase
        
        if testing {
            loadCharactersTesting()
        } else {
            loadCharacters()
        }
    }
    
    // MARK: - Functions -
    func loadCharacters() {
        status = .loading

        DispatchQueue.global().async { [weak self] in
            let dispatchGroup = DispatchGroup()
            self?.listCharacters.forEach { nameCharacter in
                dispatchGroup.enter()
                Task.init { [weak self] in
                    defer {
                        dispatchGroup.leave()
                    }
                    do {
                        guard let character = try await self?.useCase.getCharacter(by: nameCharacter, apiRouter: .getCharacter) else {
                            return
                        }
                        DispatchQueue.main.async { [weak self] in
                            self?.characters.append(character)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.status = .loaded
                print("Héroes cargados")
            }
        }
    }
    
    func loadCharactersTesting() {
        status = .loading
        
        for _ in 1...5 {
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
        
        status = .loaded
    }
}
