//
//  CharacterCardView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

struct CharacterCardView: View {
    
    var viewModel: CharactersViewModel
    let photo: String
    let characterName: String
    let characterFavorite: Bool?
    let index: Int
    
    var body: some View {
        AsyncImage(url: URL(string: photo)) { photo in
            photo
                .resizable()
                .frame(height: 275)
                .cornerRadius(20)
                .overlay(
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.clear, .clear, .clear, .black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                        .cornerRadius(20)
                        VStack {
                            HStack {
                                Text(characterName)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                                Button {
                                    //action
                                } label: {
                                    if let isFavorite: Bool = characterFavorite {
                                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 28, height: 28)
                                            .foregroundColor(.white)
                                    } else {
                                        Image(systemName: "heart")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 28, height: 28)
                                            .foregroundColor(.white)
                                    }
                                }
                                .onTapGesture {
                                    viewModel.toggleCharacterFavoriteStatus(index: index)
                                }
                            }
                            .padding()
                            Spacer()
                        }
                    }
                )
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 275)
                    .foregroundColor(.gray)
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCardView(viewModel: CharactersViewModel(), photo: "", characterName: "", characterFavorite: true, index: 1)
    }
}
