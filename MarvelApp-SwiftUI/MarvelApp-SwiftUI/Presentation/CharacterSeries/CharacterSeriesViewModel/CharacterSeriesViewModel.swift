//
//  CharacterSeriesViewModel.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

// MARK: - CharactersViewStatus -
enum CharactersSeriesViewStatus {
    case none, loading, loaded, error
}

// MARK: - CharacterSeriesViewModel -
final class CharacterSeriesViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var series: Series = []
    @Published var status: CharactersSeriesViewStatus = .none
    var character: Character
    
    // MARK: - Use Case -
    let apiClientUseCase: APIClientUseCaseProtocol
    
    // MARK: - Initializers -
    init(testing: Bool, apiClientUseCase: APIClientUseCaseProtocol = APIClientUseCase(), character: Character) {
        self.apiClientUseCase = apiClientUseCase
        self.character = character
        
        if testing {
            loadSeriesTesting()
        } else {
            loadSeries()
        }
    }
    
    // MARK: - Functions -
    func loadSeries() {
        status = .loading
        
        DispatchQueue.global().async {
            Task.init { [weak self] in
                do {
                    guard let characterId = self?.character.id else {
                        return
                    }
                    guard let series = try await self?.apiClientUseCase.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId)) else {
                        return
                    }
                    let seriesFiltered = series.filter { $0.description != nil }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.series = seriesFiltered
                        self?.status = .loaded
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func loadSeriesTesting() {
        Task.init { [weak self] in
            do {
                guard let series = try await self?.apiClientUseCase.getSeries(by: 0, apiRouter: .getSeries(characterId: 0)) else {
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.series = series
                    self?.status = .loaded
                }
            } catch {
                print(error)
            }
        }
    }
}
