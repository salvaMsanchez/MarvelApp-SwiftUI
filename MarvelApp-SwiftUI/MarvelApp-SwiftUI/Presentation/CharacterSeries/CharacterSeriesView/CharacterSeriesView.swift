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
        ZStack {
            List {
                ForEach(viewModel.series) { serie in
                    Text(serie.title)
                }
            }
            switch viewModel.status {
                case .loading:
                    let _ = print("Estado Series .loading")
                    LoadingView()
                case .loaded:
                    let _ = print("Estado Series .loaded")
                case .none:
                    let _ = print("Estado Series .none")
                case .error:
                    let _ = print("Estado Series .error")
            }
            
        }
    }
}

struct CharacterSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess(), character: .init(id: 1, name: "", description: "", thumbnail: .init(path: "", thumbnailExtension: .jpg))))
    }
}
