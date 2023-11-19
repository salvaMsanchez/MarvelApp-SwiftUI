//
//  RouteViewModel.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 15/11/23.
//

import Foundation

// MARK: - RouteViewModel -
final class RouteViewModel: ObservableObject {
    // MARK: - Properties -
    @Published var status: RoutingStatus = .none
}
