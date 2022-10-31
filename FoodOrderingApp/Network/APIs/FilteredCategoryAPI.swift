//
//  FilteredCategoryAPI.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

protocol FilteredCategoryFetchable {
    func retrieveFilteredList(request: FilteredCategoryRequestModel, completion: @escaping (Result<FilteredCategoryModel, ApiError>) -> Void)
}

final class FilteredCategoryAPI: FilteredCategoryFetchable {
    
    private let networkManager : Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveFilteredList(request: FilteredCategoryRequestModel, completion: @escaping (Result<FilteredCategoryModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
