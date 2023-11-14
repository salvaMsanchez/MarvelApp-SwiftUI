//
//  APIClient.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

// MARK: - Constants -
struct Constants {
    static let apikey = "4837bc10899562b5f7ebc30e1656c4b9"
    static let ts = "1"
    static let hash = "05418622293818d89a3ede300147d088"
    static let orderBy = "-modified"
}

// MARK: - APIClientProtocol -
protocol APIClientProtocol {
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> CharacterResults
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> SerieResults
}

// MARK: - APIRouter -
enum APIRouter {
    case getCharacter
    case getSeries(characterId: Int)
    
    var host: String {
        switch self {
            case .getCharacter, .getSeries:
                return "gateway.marvel.com"
        }
    }
    
    var scheme: String {
        switch self {
            case .getCharacter, .getSeries:
                return "https"
        }
    }
    
    var path: String {
        switch self {
            case .getCharacter:
                return "/v1/public/characters"
            case .getSeries(let characterId):
                return "/v1/public/characters/\(characterId)/series"
        }
    }
    
    var method: String {
        switch self {
            case .getCharacter, .getSeries:
                return "GET"
        }
    }
}

// MARK: - APIClient -
final class APIClient: APIClientProtocol {
    // MARK: - APIError -
    enum APIError: Error {
        case unknown
        case malformedUrl
        case decodingFailed
        case encodingFailed
        case noData
        case statusCode(code: Int?)
    }
    
    // MARK: - Functions -
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> CharacterResults {
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        
        // Define los parámetros
        let apiKeyItem = URLQueryItem(name: "apikey", value: Constants.apikey)
        let tsItem = URLQueryItem(name: "ts", value: Constants.ts)
        let hashItem = URLQueryItem(name: "hash", value: Constants.hash)
        let orderByItem = URLQueryItem(name: "orderBy", value: Constants.orderBy)
        let nameItem = URLQueryItem(name: "name", value: characterName)

        // Agrega los parámetros a la URL
        components.queryItems = [apiKeyItem, tsItem, hashItem, orderByItem, nameItem]
        
        guard let url = components.url else {
            throw APIError.malformedUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRouter.method
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let statusCode = response.getStatusCode()
        guard statusCode == 200 else {
            throw APIError.statusCode(code: statusCode)
        }
        
        guard !data.isEmpty else {
            throw APIError.noData
        }
        
        guard let resource = try? JSONDecoder().decode(CharacterResults.self, from: data) else {
            throw APIError.decodingFailed
        }
        
        return resource
    }
    
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> SerieResults {
        var components = URLComponents()
        components.host = apiRouter.host
        components.scheme = apiRouter.scheme
        components.path = apiRouter.path
        
        // Define los parámetros
        let apiKeyItem = URLQueryItem(name: "apikey", value: Constants.apikey)
        let tsItem = URLQueryItem(name: "ts", value: Constants.ts)
        let hashItem = URLQueryItem(name: "hash", value: Constants.hash)
        let limitItem = URLQueryItem(name: "limit", value: "50")

        // Agrega los parámetros a la URL
        components.queryItems = [apiKeyItem, tsItem, hashItem, limitItem]
        
        guard let url = components.url else {
            throw APIError.malformedUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiRouter.method
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let statusCode = response.getStatusCode()
        guard statusCode == 200 else {
            throw APIError.statusCode(code: statusCode)
        }
        
        guard !data.isEmpty else {
            throw APIError.noData
        }
        
        guard let resource = try? JSONDecoder().decode(SerieResults.self, from: data) else {
            throw APIError.decodingFailed
        }
        
        return resource
    }
}
