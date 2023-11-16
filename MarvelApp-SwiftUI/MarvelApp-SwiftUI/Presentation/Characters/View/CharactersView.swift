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
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 12) {
                            ForEach(viewModel.characters) { character in
                                let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                                NavigationLink {
                                    Text(character.name)
                                } label: {
                                    VStack {
                                        AsyncImage(url: URL(string: characterPhoto)) { photo in
                                            photo
                                                .resizable()
                                                .frame(width: 116, height: 150)
                                                .cornerRadius(20)
                                        } placeholder: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .frame(width: 100, height: 150)
                                                    .foregroundColor(.gray)
                                                Image(systemName: "person")
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                    .padding()
                                            }
                                        }
                                        Text(character.name)
                                            .bold()
                                            .frame(width: 100, alignment: .leading)
                                            .lineLimit(1)
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .padding([.leading, .trailing], 16)
                        .background(.blue)
                    }
                    .frame(height: 200)
                    .background(.red)
                    List {
                        ForEach(viewModel.characters) { character in
                            ZStack {
                                NavigationLink {
                                    CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character))
                                        .navigationTitle("\(character.name) Series")
                                        .navigationBarTitleDisplayMode(.inline)
                                } label: {
                                    
                                }
                                .opacity(0.0)
                                .buttonStyle(PlainButtonStyle())
                                HStack {
                                    Text(character.name)
                                        .font(.body)
                                    Spacer()
                                }
                            }
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
