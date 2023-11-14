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
            List {
                ForEach(viewModel.characters) { character in
                    NavigationLink {
                        CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character))
                    } label: {
                        Text(character.name)
                    }
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
