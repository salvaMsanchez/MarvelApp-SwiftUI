//
//  LoadingView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 15/11/23.
//

import SwiftUI

// MARK: - LoadingView -
struct LoadingView: View {
    // MARK: - Body -
    var body: some View {
            LottieView(filename: "marvelCharactersAnimation")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.edgesIgnoringSafeArea(.all).opacity(0.8))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
