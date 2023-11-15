//
//  RouteView.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 15/11/23.
//

import SwiftUI

struct RouteView: View {
    
    @EnvironmentObject var routeViewModel: RouteViewModel
    
    var body: some View {
        // StatusBox / ViewRouter
        switch routeViewModel.status {
            case .none:
                withAnimation {
                    SplashView(viewModel: SplashViewModel())
                }
        }
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
            .environmentObject(RouteViewModel())
    }
}
