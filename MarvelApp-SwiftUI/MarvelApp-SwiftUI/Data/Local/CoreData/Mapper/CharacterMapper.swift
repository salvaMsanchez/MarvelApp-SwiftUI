//
//  CharacterMapper.swift
//  MarvelApp-SwiftUI
//
//  Created by Salva Moreno on 17/11/23.
//

import Foundation

struct CharacterMapper {
    static func mapCharacterDAOToCharacter(_ characterDAO: CharacterDAO) -> Character? {
        guard let name = characterDAO.name,
              let description = characterDAO.characterDescription,
              let thumbnail = characterDAO.thumbnail else {
            return nil
        }
        
        let components = thumbnail.split(separator: ".")
        let thumbnailPath = components.dropLast().joined(separator: ".")
        let thumbnailExtension = components.last ?? ""
        
        return Character(id: Int(characterDAO.id), name: name, description: description, thumbnail: .init(path: thumbnailPath, thumbnailExtension: thumbnailExtension.elementsEqual("gif") ? .gif : .jpg), favorite: characterDAO.favorite)
    }
}
