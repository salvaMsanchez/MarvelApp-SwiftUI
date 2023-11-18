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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all).opacity(0.8))
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
