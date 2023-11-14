//
//  SplashView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        LottieView(filename: "marvelSplashAnimation")
            .frame(width: 300, height: 300)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
