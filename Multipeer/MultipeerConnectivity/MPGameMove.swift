//
//  MPGameMove.swift
//  Multipeer
//
//  Created by Kurnia Kharisma Agung Samiadjie on 27/04/24.
//

import Foundation

struct MPGameMove: Codable {
    enum Action: Int, Codable {
        case start, give, reset, end
    }

    let action: Action
    let user_character: String?
    let ingredientId: Int?

    func data() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

