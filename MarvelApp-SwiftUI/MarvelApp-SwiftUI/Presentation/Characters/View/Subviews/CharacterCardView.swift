//
//  CharacterCardView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

// MARK: - CharacterCardView -
struct CharacterCardView: View {
    // MARK: - Properties -
    var viewModel: CharactersViewModel
    let photo: String
    let characterName: String
    let characterFavorite: Bool?
    let index: Int
    let height: CGFloat
    let fontSize: CGFloat
    let heartSize: CGFloat
    
    // MARK: - Body -
    var body: some View {
        // Image
        AsyncImage(url: URL(string: photo)) { photo in
            photo
                .resizable()
                .frame(height: height)
                .cornerRadius(20)
                .overlay(
                    ZStack {
                        // Gradient
                        LinearGradient(gradient: Gradient(colors: [.clear, .clear, .clear, .black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                        .cornerRadius(20)
                        VStack {
                            HStack {
                                // Name
                                Text(characterName)
                                    .font(.system(size: fontSize))
                                    .foregroundColor(.white)
                                    .bold()
                                    .lineLimit(1)
                                Spacer()
                                // Favorite Button
                                Button {
                                    
                                } label: {
                                    if let isFavorite: Bool = characterFavorite {
                                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: heartSize, height: heartSize)
                                            .foregroundColor(.white)
                                    } else {
                                        Image(systemName: "heart")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: heartSize, height: heartSize)
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
                    .frame(height: height)
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
        CharacterCardView(viewModel: CharactersViewModel(), photo: "", characterName: "", characterFavorite: true, index: 1, height: 275, fontSize: 18, heartSize: 28)
    }
}
