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
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> Series
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
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
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
        
        if let character = resource.characters.first {
            return character
        } else {
            return .init(id: 0, name: "", description: "", thumbnail: .init(path: "", thumbnailExtension: .jpg))
        }
    }
    
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> Series {
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
        
        return resource.series
    }
}

// MARK: - APIClientFakeSuccess -
final class APIClientFakeSuccess: APIClientProtocol {
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
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
        
        let randomNum = Int.random(in: 0..<Int.max)
        
        let characters: Characters = [
            .init(id: randomNum, name: "Iron Man", description: "Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55", thumbnailExtension: .jpg)),
            .init(id: randomNum, name: "Avengers", description: "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team.", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/20/5102c774ebae7", thumbnailExtension: .jpg)),
            .init(id: randomNum, name: "Hulk", description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0", thumbnailExtension: .jpg)),
            .init(id: randomNum, name: "Wolverine", description: "Born with super-human senses and the power to heal from almost any wound, Wolverine was captured by a secret Canadian organization and given an unbreakable skeleton and claws. Treated like an animal, it took years for him to control himself. Now, he's a premiere member of both the X-Men and the Avengers.", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/60/537bcaef0f6cf", thumbnailExtension: .jpg))
        ]
        
        if let character = characters.randomElement() {
            return character
        } else {
            return .init(id: 0, name: "", description: "", thumbnail: .init(path: "", thumbnailExtension: .jpg))
        }
    }
    
    func getSeries(by characterId: Int, apiRouter: APIRouter) async throws -> Series {
        let series: Series = [
            .init(id: 16450, title: "A+X (2012 - 2014)", description: "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34", thumbnailExtension: "jpg")),
            .init(id: 454, title: "Amazing Spider-Man (1999 - 2013)", description: "Looking for the one superhero comic you just have to read? You've found it! <i>Amazing Spider-Man</i> is the cornerstone of the Marvel Universe. This is where you'll find all the big-time action, major storylines and iconic Spider-Man magic you'd come to expect from the Wall-Crawler.", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/f0/51252718e1c2d", thumbnailExtension: "jpg")),
            .init(id: 1, title: "A+X (2012 - 2014)", description: "Get ready for action-packed stories featuring team-ups from your favorite Marvel heroes every month! First, a story where Wolverine and Hulk come together, and then Captain America and Cable meet up! But will each partner's combined strength be enough?", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34", thumbnailExtension: "jpg")),
            .init(id: 2, title: "Amazing Spider-Man (1999 - 2013)", description: "Looking for the one superhero comic you just have to read? You've found it! <i>Amazing Spider-Man</i> is the cornerstone of the Marvel Universe. This is where you'll find all the big-time action, major storylines and iconic Spider-Man magic you'd come to expect from the Wall-Crawler.", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/2/f0/51252718e1c2d", thumbnailExtension: "jpg"))
        ]
        
        return series
    }
}
