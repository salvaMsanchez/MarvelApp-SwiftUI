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
    let height: CGFloat
    let fontSize: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: photo)) { photo in
            photo
                .resizable()
                .frame(height: height)
                .cornerRadius(20)
                .overlay(
                    ZStack {
                        #if os(watchOS)
                        LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black.opacity(0.6), .black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                        .cornerRadius(20)
                        #else
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.9), .black.opacity(0.6), .clear, .black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                        .cornerRadius(20)
                        #endif
                        VStack {
                            HStack {
                                Text(serieTitle)
                                    .font(.system(size: fontSize))
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                            }
                            .padding()
                            Spacer()
                            #if os(watchOS)
                            
                            #else
                            HStack {
                                Text(serieDescription ?? "")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .bold()
                                    .lineLimit(4)
                            }
                            .padding()
                            #endif
                        }
                    }
                )
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: height)
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
        SerieCardView(photo: "", serieTitle: "", serieDescription: "", height: 390, fontSize: 28)
    }
}
