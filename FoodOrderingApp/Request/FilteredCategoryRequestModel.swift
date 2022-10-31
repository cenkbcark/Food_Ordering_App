//
//  FilteredCategoryRequestModel.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

final class FilteredCategoryRequestModel: RequestModel {
    
    private let categoryTitle: String
    
    init(categoryTitle: String) {
        self.categoryTitle = categoryTitle
    }
    
    override var baseURL: String {
        Constant.API.baseURL
    }
    
    override var path: String {
        Constant.API.filterCategory
    }
    
    override var filterKeyword: String {
        categoryTitle
    }
    
    override var method: RequestMethod {
        .get
    }
    
    override var parameters: [String : Any?] {
        [
            "c": categoryTitle
        ]
    }
    
    
}
