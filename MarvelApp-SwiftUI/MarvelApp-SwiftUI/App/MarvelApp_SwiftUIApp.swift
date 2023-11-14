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

    var body: some Scene {
        WindowGroup {
            CharactersView(viewModel: CharactersViewModel(testing: true, useCase: APIClientUseCaseFakeSuccess()))
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
