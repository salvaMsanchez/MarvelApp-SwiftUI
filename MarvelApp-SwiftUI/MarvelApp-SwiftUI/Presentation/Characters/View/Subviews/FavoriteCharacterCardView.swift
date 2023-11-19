//
//  FavoriteCharacterCardView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

// MARK: - FavoriteCharacterCardView -
struct FavoriteCharacterCardView: View {
    // MARK: - Properties -
    let photo: String
    let characterName: String
    
    // MARK: - Body -
    var body: some View {
        VStack {
            // Image
            AsyncImage(url: URL(string: photo)) { photo in
                photo
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 150)
                    .cornerRadius(20)
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 120, height: 150)
                        .foregroundColor(.gray)
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .foregroundColor(.black)
                }
            }
            // Name
            Text(characterName)
                .bold()
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
                .font(.system(size: 14))
                .foregroundColor(Color.customText)
        }
    }
}

struct FavoriteCharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCharacterCardView(photo: "", characterName: "")
    }
}
