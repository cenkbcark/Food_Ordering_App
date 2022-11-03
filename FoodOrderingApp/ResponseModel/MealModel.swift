//
//  MealModel.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

struct MealResponse: Codable {
    var meals: [FoodResponse]?
}
struct FoodResponse : Codable {
    let strMeal : String?
    var strCategory : String?
    let strArea : String?
    let strInstructions : String?
    let strMealThumb : String?
    
}
