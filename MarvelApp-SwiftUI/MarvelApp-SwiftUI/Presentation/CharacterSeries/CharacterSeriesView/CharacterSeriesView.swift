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
                    let seriePhoto: String = "\(serie.thumbnail.path).\(serie.thumbnail.thumbnailExtension)"
                    AsyncImage(url: URL(string: seriePhoto)) { photo in
                        photo
                            .resizable()
                            .frame(height: 390)
                            .cornerRadius(20)
                            .overlay(
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.9), .black.opacity(0.6), .clear, .black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                                    .cornerRadius(20)
                                    VStack {
                                        HStack {
                                            Text(serie.title)
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .bold()
                                            Spacer()
                                        }
                                        .padding()
                                        Spacer()
                                        HStack {
                                            Text(serie.description ?? "")
                                                .font(.body)
                                                .foregroundColor(.white)
                                                .bold()
                                                .lineLimit(4)
                                        }
                                        .padding()
                                    }
                                }
                            )
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 390)
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
