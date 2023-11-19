//
//  MarvelApp_SwiftUIApp.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import SwiftUI

@main
struct MarvelApp_SwiftUIApp: App {
    @StateObject var routeViewModel = RouteViewModel()

    var body: some Scene {
        WindowGroup {
            RouteView()
                .environmentObject(routeViewModel)
        }
    }
}
