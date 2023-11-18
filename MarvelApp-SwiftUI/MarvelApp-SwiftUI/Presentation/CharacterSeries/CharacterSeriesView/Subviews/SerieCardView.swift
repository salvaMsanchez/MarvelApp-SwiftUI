//
//  SerieCardView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

struct SerieCardView: View {
    
    let photo: String
    let serieTitle: String
    let serieDescription: String?
    
    var body: some View {
        AsyncImage(url: URL(string: photo)) { photo in
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
                                Text(serieTitle)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                            }
                            .padding()
                            Spacer()
                            HStack {
                                Text(serieDescription ?? "")
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

struct SerieCardView_Previews: PreviewProvider {
    static var previews: some View {
        SerieCardView(photo: "", serieTitle: "", serieDescription: "")
    }
}
