//
//  NoFavoriteCharactersView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

// MARK: - NoFavoriteCharactersView -
struct NoFavoriteCharactersView: View {
    // MARK: - Body -
    var body: some View {
        Rectangle()
            .frame(height: 200)
            .foregroundColor(.gray)
            .overlay(
                VStack(spacing: 16) {
                    // Image
                    Image(systemName: "heart.slash.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                    // Text
                    Text("No favorite characters saved yet")
                }
            )
    }
}

struct NoFavoriteCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        NoFavoriteCharactersView()
    }
}
