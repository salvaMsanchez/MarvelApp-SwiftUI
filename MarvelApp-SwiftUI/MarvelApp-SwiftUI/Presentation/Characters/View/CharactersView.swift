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
            ZStack {
                List {
                    Section {
                        if viewModel.favoritesCharacters.isEmpty {
                            Rectangle()
                                .frame(height: 200)
                                .foregroundColor(.gray)
                                .overlay(
                                    VStack {
                                        Image(systemName: "heart.slash.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.black)
                                        Text("No favorite characters saved yet")
                                    }
                                )
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 12) {
                                    ForEach(viewModel.characters) { character in
                                        let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                                        NavigationLink {
                                            Text(character.name)
                                        } label: {
                                            VStack {
                                                AsyncImage(url: URL(string: characterPhoto)) { photo in
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
                                                Text(character.name)
                                                    .bold()
                                                    .frame(width: 100, alignment: .leading)
                                                    .lineLimit(1)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                                .padding([.leading, .trailing], 16)
                                .background(.blue)
                            }
                            .frame(height: 200)
                            .background(.red)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 0,leading: 0,bottom: -20,trailing: 0))
                    ForEach(Array(viewModel.characters.enumerated()), id: \.element.id) { index, character in
                        let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
                        ZStack {
                            NavigationLink {
                                CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character))
                                    .navigationTitle("\(character.name) Series")
                                    .navigationBarTitleDisplayMode(.inline)
                            } label: {
                                
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            HStack {
                                AsyncImage(url: URL(string: characterPhoto)) { photo in
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
                                                        Text(character.name)
                                                            .font(.title)
                                                            .foregroundColor(.white)
                                                            .bold()
                                                        Spacer()
                                                        Button {
                                                            //action
                                                        } label: {
                                                            if let isFavorite: Bool = character.favorite {
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
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.grouped)
                switch viewModel.status {
                    case .loading:
                        let _ = print("Estado Characters .loading")
                        LoadingView()
                    case .loaded:
                        let _ = print("Estado Characters .loaded")
                    case .none:
                        let _ = print("Estado Characters .none")
                    case .error:
                        let _ = print("Estado Characters .error")
                }
            }
            .navigationTitle("Marvel Heroes")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: CharactersViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess()))
    }
}

//VStack {
//    if viewModel.favoritesCharacters.isEmpty {
//        Rectangle()
//            .frame(height: 200)
//            .foregroundColor(.gray)
//            .overlay(
//                VStack {
//                    Image(systemName: "heart.slash.fill")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .foregroundColor(.black)
//                    Text("No favorite characters saved yet")
//                }
//            )
//    } else {
//        ScrollView(.horizontal, showsIndicators: false) {
//            LazyHStack(spacing: 12) {
//                ForEach(viewModel.characters) { character in
//                    let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
//                    NavigationLink {
//                        Text(character.name)
//                    } label: {
//                        VStack {
//                            AsyncImage(url: URL(string: characterPhoto)) { photo in
//                                photo
//                                    .resizable()
//                                    .frame(width: 116, height: 150)
//                                    .cornerRadius(20)
//                            } placeholder: {
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .frame(width: 100, height: 150)
//                                        .foregroundColor(.gray)
//                                    Image(systemName: "person")
//                                        .resizable()
//                                        .frame(width: 50, height: 50)
//                                        .padding()
//                                        .foregroundColor(.black)
//                                }
//                            }
//                            Text(character.name)
//                                .bold()
//                                .frame(width: 100, alignment: .leading)
//                                .lineLimit(1)
//                                .font(.system(size: 14))
//                                .foregroundColor(.white)
//                        }
//                    }
//                }
//            }
//            .padding([.leading, .trailing], 16)
//            .background(.blue)
//        }
//        .frame(height: 200)
//        .background(.red)
//    }
//    List {
//        ForEach(viewModel.characters) { character in
//            let characterPhoto: String = "\(character.thumbnail.path).\(character.thumbnail.thumbnailExtension.rawValue)"
//            ZStack {
//                NavigationLink {
//                    CharacterSeriesView(viewModel: CharacterSeriesViewModel(testing: false, character: character))
//                        .navigationTitle("\(character.name) Series")
//                        .navigationBarTitleDisplayMode(.inline)
//                } label: {
//
//                }
//                .opacity(0.0)
//                .buttonStyle(PlainButtonStyle())
//                HStack {
//                    AsyncImage(url: URL(string: characterPhoto)) { photo in
//                        photo
//                            .resizable()
//                            .frame(width: .infinity, height: 300)
//                            .cornerRadius(20)
//                    } placeholder: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 20)
//                                .frame(width: 100, height: 150)
//                                .foregroundColor(.gray)
//                            Image(systemName: "person")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .padding()
//                                .foregroundColor(.black)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
