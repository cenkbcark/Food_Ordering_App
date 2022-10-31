//
//  MealAPI.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

protocol FilteredMealFetchable {
    func retrieveMeal(request: MealResponseRequestModel, completion: @escaping (Result<MealResponse, ApiError>) -> Void)
}

final class MealAPI: FilteredMealFetchable {
    
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveMeal(request: MealResponseRequestModel, completion: @escaping (Result<MealResponse, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
