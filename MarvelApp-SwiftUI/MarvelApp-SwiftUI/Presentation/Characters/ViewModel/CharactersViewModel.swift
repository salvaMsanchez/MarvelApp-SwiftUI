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
    @Published var status: CharactersViewStatus = .none
    var favoritesCharacters: Characters {
        return characters.filter { character in
            character.favorite == true
        }
    }
    
    // MARK: - Use Case -
    let useCase: APIClientUseCaseProtocol
    let coreDataUseCase: DataPersistanceManagerUseCaseProtocol
    
    // MARK: - Initializers -
    init(testing: Bool = false, useCase: APIClientUseCaseProtocol = APIClientUseCase(), coreDataUseCase: DataPersistanceManagerUseCaseProtocol = DataPersistanceManagerUseCase()) {
        self.useCase = useCase
        self.coreDataUseCase = coreDataUseCase
        
        if testing {
            loadCharactersTesting()
        } else {
            loadCharacters()
        }
    }
    
    // MARK: - Functions -
    func toggleCharacterFavoriteStatus(index: Int) {
        // Cambio lista actual ViewModel
        switch characters[index].favorite {
            case nil:
                characters[index].favorite = true
            case true:
                characters[index].favorite = false
            case false:
                characters[index].favorite = true
            default:
                break
        }
        
        // Cambio en CoreData
        guard let characterFavorite = characters[index].favorite else { return }
        if characterFavorite {
            coreDataUseCase.updateFavorite(thisCharacter: characters[index], to: true) { result in
                switch result {
                    case .success():
                        break
                    case .failure(let error):
                        print(error)
                }
            }
        } else {
            coreDataUseCase.updateFavorite(thisCharacter: characters[index], to: false) { result in
                switch result {
                    case .success():
                        break
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func loadCharacters() {
        status = .loading
        
        let charactersSavedOnCoreData: Characters = fetchingCharactersCoreData()
        print("CONTADOR EN COREDATA -> \(charactersSavedOnCoreData.count)")
        
        if charactersSavedOnCoreData.count > 0 {
            defer {
                DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                    DispatchQueue.main.async {
                        self?.status = .loaded
                    }
                }
            }
            characters = charactersSavedOnCoreData
//            print("!!!!!!!!!!!!!")
//            print("!!!!!!!!!!!!!")
//            print(characters)
//            print("!!!!!!!!!!!!!")
//            print("!!!!!!!!!!!!!")
        } else {
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
//                    print("Héroes cargados")
                    self?.saveCharactersCoreData()
                }
            }
        }

        
    }
    
    func fetchingCharactersCoreData() -> Characters {
        var charactersCoreData: Characters = []
        coreDataUseCase.fetchingCharacters { result in
            switch result {
                case .success(let characters):
                    charactersCoreData = characters
                case .failure(let error):
                    print(error)
            }
        }
        return charactersCoreData
    }
    
    func saveCharactersCoreData() {
        coreDataUseCase.saveCharacter(characters: characters) { result in
            switch result {
                case .success():
                    print("Héroes guardados en CoreData")
                    break
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func loadCharactersTesting() {
        status = .loading
        
        let dispatchGroup = DispatchGroup()
        
        for _ in 1...5 {
            dispatchGroup.enter()
            Task.init { [weak self] in
                do {
                    guard let character = try await self?.useCase.getCharacter(by: "", apiRouter: .getCharacter) else {
                        dispatchGroup.leave()
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        self?.characters.append(character)
                        self?.saveCharactersCoreData()
                        dispatchGroup.leave()
                    }
                } catch {
                    print("Testing error: \(error)")
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            self?.status = .loaded
        }
    }
}
