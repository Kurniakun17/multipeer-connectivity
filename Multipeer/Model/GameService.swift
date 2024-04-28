//
//  GameService.swift
//  Multipeer
//
//  Created by Kurnia Kharisma Agung Samiadjie on 28/04/24.
//

import Foundation

enum ScreenPhase {
    case menu, lobby, game, end
}

class GameService: ObservableObject {
    @Published var myIngredients: [Ingredient] = []

    var screenPhase: ScreenPhase = .menu

    func setupScreen(phase: ScreenPhase) {
        screenPhase = phase
    }

    func appendItem(ingredientId: Int) {
        myIngredients.append(Ingredient.generate(id: ingredientId))
    }
}
