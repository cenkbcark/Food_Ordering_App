//
//  API.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

extension Constant {
    
    class API {
        private init() { }
        
        static let baseURL = "https://www.themealdb.com/api/json/v1/1"
        static let categoryList = "/categories.php"
        static let filterCategory = "/filter.php"
        static let filterMeal = "/lookup.php"
        
    }
}
//https://www.themealdb.com/api/json/v1/1/categories.php
//https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
//https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772
//https://www.themealdb.com/api/json/v1/1/lookup.php?i=52722

