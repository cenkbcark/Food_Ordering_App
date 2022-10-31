//
//  CategoryAPI.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

protocol CategoryFetchable {
    func retrieveCategory(request: CategoryRequestModel, completion: @escaping (Result<CategoryModel, ApiError>) -> Void)
}

final class CategoryAPI: CategoryFetchable {
    
    private let networkManager : Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveCategory(request: CategoryRequestModel, completion: @escaping (Result<CategoryModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
