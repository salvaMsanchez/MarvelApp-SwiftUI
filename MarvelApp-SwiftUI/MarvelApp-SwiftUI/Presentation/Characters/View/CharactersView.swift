//
//  CharactersView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

struct CharactersView: View {
    
    @StateObject var viewModel: CharactersViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.characters) { character in
                        NavigationLink {
                            CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character))
                                .navigationTitle("\(character.name) Series")
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            Text(character.name)
                        }
                    }
                }
                switch viewModel.status {
                    case .loading:
                        let _ = print("Estado Characters .loading")
                        LoadingView()
                    case .loaded:
                        let _ = print("Estado Characters .loaded")
                    case .none:
                        let _ = print("Estado Characters .none")
                    case .error:
                        let _ = print("Estado Characters .error")
                }
            }
            .navigationTitle("Marvel Heroes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: CharactersViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess()))
    }
}
