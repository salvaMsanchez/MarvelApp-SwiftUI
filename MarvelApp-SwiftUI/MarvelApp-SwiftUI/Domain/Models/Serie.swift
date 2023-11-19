//
//  Serie.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 14/11/23.
//

import Foundation

typealias Series = [Serie]

// MARK: - Serie -
struct Serie: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: SerieThumbnail
}

// MARK: - Result -
struct SerieResults: Decodable {
    let series: Series
    
    enum CodingKeys: String, CodingKey {
        case data
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.series = try data.decode([Serie].self, forKey: .results)
    }
}

// MARK: - Thumbnail -
struct SerieThumbnail: Decodable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
