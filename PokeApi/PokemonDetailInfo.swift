//
//  PokemonDetailInfo.swift
//  PokeApi
//
//  Created by Alejandro Mendoza on 10/23/20.
//  Copyright © 2020 Alejandro Mendoza. All rights reserved.
//

import Foundation
import UIKit

struct PokemonDetailInfo: Decodable {
    let name: String
    let officialImage: String
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case weight
        case sprites
        case other
        case officialArtwork = "official-artwork"
        case frontDefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let spritesContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        let otherSprites = try spritesContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        let officialArtwork = try otherSprites.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        
        name = try values.decode(String.self, forKey: .name)
        weight = try values.decode(Int.self, forKey: .weight)
        officialImage = try officialArtwork.decode(String.self, forKey: .frontDefault)
    }
}
