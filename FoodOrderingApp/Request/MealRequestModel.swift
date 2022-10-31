//
//  MealRequestModel.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

final class MealResponseRequestModel: RequestModel {
    
    private let mealID: String
    
    init(mealID: String) {
        self.mealID = mealID
    }
    
    override var baseURL: String {
        Constant.API.baseURL
    }
    
    override var path: String {
        Constant.API.filterMeal
    }
    
    override var filterKeyword: String? {
        mealID
    }
    
    override var method: RequestMethod {
        .get
    }
    
    override var parameters: [String : Any?] {
        [
            "i": mealID
        ]
    }
}
