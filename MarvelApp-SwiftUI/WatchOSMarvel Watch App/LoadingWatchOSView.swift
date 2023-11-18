//
//  LoadingWatchOSView.swift
//  WatchOSMarvel Watch App
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

struct LoadingWatchOSView: View {
    
    @StateObject var viewModel: LottieViewModel = .init()
    
    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .scaledToFit()
            .onAppear {
                self.viewModel.loadAnimationFromFile(filename: "marvelCharactersAnimation")
            }
    }
}

struct LoadingWatchOSView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingWatchOSView()
    }
}
