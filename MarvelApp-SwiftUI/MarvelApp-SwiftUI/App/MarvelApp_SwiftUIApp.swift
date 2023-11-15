//
//  MarvelApp_SwiftUIApp.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

@main
struct MarvelApp_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var routeViewModel = RouteViewModel()

    var body: some Scene {
        WindowGroup {
//            SplashView()
//            CharactersView(viewModel: CharactersViewModel(testing: false))
            RouteView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(routeViewModel)
        }
    }
}
