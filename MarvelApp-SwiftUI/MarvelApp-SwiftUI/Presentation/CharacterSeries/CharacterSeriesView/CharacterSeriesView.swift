//
//  CharacterSeriesView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

// MARK: - CharacterSeriesView -
struct CharacterSeriesView: View {
    // MARK: - Properties -
    @StateObject var viewModel: CharacterSeriesViewModel
    let height: CGFloat
    let fontSize: CGFloat
    
    // MARK: - Body -
    var body: some View {
        ZStack {
            // MARK: - Series List -
            List {
                ForEach(viewModel.series) { serie in
                    let seriePhoto: String = "\(serie.thumbnail.path).\(serie.thumbnail.thumbnailExtension)"
                    SerieCardView(photo: seriePhoto, serieTitle: serie.title, serieDescription: serie.description, height: height, fontSize: fontSize)
                }
            }
            .scrollIndicators(.hidden)
            switch viewModel.status {
                case .loading:
                    let _ = print("Estado Series .loading")
                    #if os(watchOS)
                    LoadingWatchOSView()
                    #else
                    LoadingView()
                    #endif
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
        CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess(), character: .init(id: 1, name: "", description: "", thumbnail: .init(path: "", thumbnailExtension: .jpg))), height: 390, fontSize: 28)
    }
}
