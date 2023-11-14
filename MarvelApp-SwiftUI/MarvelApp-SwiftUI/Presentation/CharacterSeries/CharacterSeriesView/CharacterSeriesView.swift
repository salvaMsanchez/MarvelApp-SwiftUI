//
//  CharacterSeriesView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

struct CharacterSeriesView: View {
    
    @StateObject var viewModel: CharacterSeriesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.series) { serie in
                Text(serie.title)
            }
        }
    }
}

struct CharacterSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess(), character: .init(id: 1, name: "", description: "", thumbnail: .init(path: "", thumbnailExtension: .jpg))))
    }
}
