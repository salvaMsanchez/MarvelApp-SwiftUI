//
//  SplashViewModel.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

// MARK: - SplashViewStatus -
enum SplashViewStatus {
    case none, loading, loaded, error
}

final class SplashViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var status: SplashViewStatus = .none
    
    // MARK: - Initializers -
    init() {
        checkDataStatus()
    }
    
    // MARK: - Functions -
    func checkDataStatus() {
        status = .loading
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            DispatchQueue.main.async {
                self?.status = .loaded
            }
        }
    }
}
