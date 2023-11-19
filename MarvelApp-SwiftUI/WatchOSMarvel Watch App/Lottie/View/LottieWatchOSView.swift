//
//  LottieWatchOSView.swift
//  WatchOSMarvel Watch App
//
//  Created by Salva Moreno on 18/11/23.
//

import SwiftUI

// MARK: - LottieWatchOSView -
struct LottieWatchOSView: View {
    // MARK: - Properties -
    @StateObject var viewModel: LottieViewModel = .init()
    
    // MARK: - Body -
    var body: some View {
        // Image
        Image(uiImage: viewModel.image)
            .resizable()
            .scaledToFit()
            .onAppear {
                self.viewModel.loadAnimationFromFile(filename: "marvelSplashAnimation")
            }
    }
}

struct LottieWatchOSView_Previews: PreviewProvider {
    static var previews: some View {
        LottieWatchOSView()
    }
}
