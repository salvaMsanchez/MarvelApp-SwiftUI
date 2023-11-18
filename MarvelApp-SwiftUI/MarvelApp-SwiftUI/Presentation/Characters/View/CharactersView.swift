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
                    // MARK: - FavoriteCharacters -
                    Section {
                        if viewModel.favoritesCharacters.isEmpty {
                            NoFavoriteCharactersView()
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 12) {
                                    ForEach(viewModel.favoritesCharacters) { character in
                                        let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                                        NavigationLink {
                                            CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character))
                                                .navigationTitle("\(character.name) Series")
                                                .navigationBarTitleDisplayMode(.inline)
                                        } label: {
                                            FavoriteCharacterCardView(photo: characterPhoto, characterName: character.name)
                                        }
                                    }
                                }
                                .padding([.leading, .trailing], 16)
                                .background(.blue)
                            }
                            .frame(height: 200)
                            .background(.red)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0,leading: 0,bottom: -20,trailing: 0))
                    // MARK: - Characters -
                    ForEach(Array(viewModel.characters.enumerated()), id: \.element.id) { index, character in
                        let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                        ZStack {
                            NavigationLink {
                                CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character))
                                    .navigationTitle("\(character.name) Series")
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: { }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            HStack {
                                CharacterCardView(viewModel: viewModel, photo: characterPhoto, characterName: character.name, characterFavorite: character.favorite, index: index)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.grouped)
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
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: CharactersViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess()))
    }
}
