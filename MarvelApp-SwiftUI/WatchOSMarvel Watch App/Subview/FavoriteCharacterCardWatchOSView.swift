//
//  FavoriteCharacterCardWatchOSView.swift
//  WatchOSMarvel Watch App
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

// MARK: - FavoriteCharacterCardWatchOSView -
struct FavoriteCharacterCardWatchOSView: View {
    // MARK: - Properties -
    let photo: String
    let characterName: String
    
    // MARK: - Body -
    var body: some View {
        // Image
        AsyncImage(url: URL(string: photo)) { photo in
            photo
                .resizable()
                .frame(height: 175)
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
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                            }
                            .padding()
                            Spacer()
                        }
                    }
                )
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 175)
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

struct FavoriteCharacterCardWatchOSView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCharacterCardWatchOSView(photo: "", characterName: "")
    }
}
