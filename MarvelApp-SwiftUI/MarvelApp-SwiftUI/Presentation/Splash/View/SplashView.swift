//
//  SplashView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

// MARK: - SplashView -
struct SplashView: View {
    // MARK: - Properties -
    @EnvironmentObject var routeViewModel: RouteViewModel
    @StateObject var viewModel: SplashViewModel
    
    // MARK: - Body -
    var body: some View {
        switch viewModel.status {
            case .none:
                let _ = print("Estado Splash .none")
            case .loading:
                let _ = print("Estado Splash .loading")
                #if os(watchOS)
                LottieWatchOSView()
                #else
                ZStack {
                    Color.customBackground
                        .edgesIgnoringSafeArea(.all)
                    LottieView(filename: "marvelSplashAnimation")
                }
                
                #endif
            case .loaded:
                let _ = print("Estado Splash .loaded")
                withAnimation {
                    CharactersView(viewModel: CharactersViewModel())
                }
            case .error:
                let _ = print("Estado Splash .error")
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
            .environmentObject(RouteViewModel())
    }
}
