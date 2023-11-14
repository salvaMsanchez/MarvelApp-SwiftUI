//
//  CharacterSeriesViewModel.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

final class CharacterSeriesViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var series: Series = []
    var character: Character
    
    // MARK: - Use Case -
    let useCase: APIClientUseCaseProtocol
    
    // MARK: - Initializers -
    init(testing: Bool, useCase: APIClientUseCaseProtocol = APIClientUseCase(), character: Character) {
        self.useCase = useCase
        self.character = character
        
        if testing {
            loadSeriesTesting()
        } else {
            loadSeries()
        }
    }
    
    // MARK: - Functions -
    func loadSeries() {
//        state = .loading
        DispatchQueue.global().async {
            Task.init { [weak self] in
                do {
                    guard let characterId = self?.character.id else {
                        return
                    }
                    guard let series = try await self?.useCase.getSeries(by: characterId, apiRouter: .getSeries(characterId: characterId)) else {
                        return
                    }
                    let seriesFiltered = series.filter { $0.description != nil }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.series = seriesFiltered
                    }
//                    self?.state = .loaded
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func loadSeriesTesting() {
        Task.init { [weak self] in
            do {
                guard let series = try await self?.useCase.getSeries(by: 0, apiRouter: .getSeries(characterId: 0)) else {
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.series = series
                }
//                    self?.state = .loaded
            } catch {
                print(error)
            }
        }
    }
}