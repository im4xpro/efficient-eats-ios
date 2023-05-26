//
//  RecipeIngredient.swift
//  mealmate-ios
//
//  Created by Maximilian Kaiser on 26.05.23.
//

import Foundation

struct RecipeIngredient: Identifiable {
    let id = UUID()
    let amount: Double
    let item: any ConsumableItem
}

extension RecipeIngredient {
    static let mockData = [
        RecipeIngredient(amount: 2, item: Ingredient(name: "Flour")),
        RecipeIngredient(amount: 2, item: Ingredient(name: "Milk")),
        RecipeIngredient(amount: 0.1, item: Ingredient(name: "Salt")),
        RecipeIngredient(amount: 2, item: Ingredient(name: "Eggs")),
    ]
}
