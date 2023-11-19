//
//  CharactersView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

// MARK: - CharactersView -
struct CharactersView: View {
    // MARK: - Properties -
    @StateObject var viewModel: CharactersViewModel
    @State private var showFavorites = false
    
    // MARK: - Body -
    var body: some View {
        NavigationStack {
            ZStack {
                #if os(watchOS)
                // MARK: - Characters List WatchOS -
                List {
                    Section {
                        // Favorites Toggle
                        Toggle(isOn: $showFavorites) {
                            Text("My Favorites")
                        }
                        if showFavorites {
                            // Favorites List
                            ForEach(viewModel.favoritesCharacters) { character in
                                let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                                NavigationLink {
                                    CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character), height: 175, fontSize: 18)
                                        .navigationTitle("\(character.name) Series")
                                        .navigationBarTitleDisplayMode(.inline)
                                } label: {
                                    FavoriteCharacterCardWatchOSView(photo: characterPhoto, characterName: character.name)
                                }
                                .listRowBackground(Color.black)
                            }
                        } else {
                            // Characters List
                            ForEach(Array(viewModel.characters.enumerated()), id: \.element.id) { index, character in
                                let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                                ZStack {
                                    NavigationLink {
                                        CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character), height: 175, fontSize: 18)
                                            .navigationTitle("\(character.name) Series")
                                            .navigationBarTitleDisplayMode(.inline)
                                    } label: { }
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                    HStack {
                                        CharacterCardView(viewModel: viewModel, photo: characterPhoto, characterName: character.name, characterFavorite: character.favorite, index: index, height: 175, fontSize: 18, heartSize: 24)
                                    }
                                }
                                .listRowBackground(Color.black)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                #else
                // MARK: - Characters List iOS -
                List {
                    // Favorites List
                    Section {
                        if viewModel.favoritesCharacters.isEmpty {
                            NoFavoriteCharactersView()
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 12) {
                                    ForEach(viewModel.favoritesCharacters) { character in
                                        let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                                        NavigationLink {
                                            CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character), height: 390, fontSize: 24)
                                                .navigationTitle("\(character.name) Series")
                                                .navigationBarTitleDisplayMode(.inline)
                                        } label: {
                                            FavoriteCharacterCardView(photo: characterPhoto, characterName: character.name)
                                        }
//                                        .listRowBackground(Color.customBackground)
                                    }
                                }
                                .padding([.leading, .trailing], 16)
//                                .background(.blue)
                            }
                            .frame(height: 200)
                            .background(Color.customBackground)
                            .scrollContentBackground(.hidden)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: -20, trailing: 0))
                    // Characters List
                    ForEach(Array(viewModel.characters.enumerated()), id: \.element.id) { index, character in
                        let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                        ZStack {
                            NavigationLink {
                                CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character), height: 390, fontSize: 24)
                                    .navigationTitle("\(character.name) Series")
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: { }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            HStack {
                                CharacterCardView(viewModel: viewModel, photo: characterPhoto, characterName: character.name, characterFavorite: character.favorite, index: index, height: 275, fontSize: 32, heartSize: 28)
                            }
                        }
                        .listRowBackground(Color.customBackground)
                    }
                }
                .background(Color.customBackground)
                .scrollIndicators(.hidden)
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                #endif
                switch viewModel.status {
                    case .loading:
                        let _ = print("Estado Characters .loading")
                        #if os(watchOS)
                        LoadingWatchOSView()
                        #else
                        LoadingView()
                        #endif
                    case .loaded:
                        let _ = print("Estado Characters .loaded")
                    case .none:
                        let _ = print("Estado Characters .none")
                    case .error:
                        let _ = print("Estado Characters .error")
                }
            }
            .navigationTitle("Marvel Heroes")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: CharactersViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess()))
    }
}
