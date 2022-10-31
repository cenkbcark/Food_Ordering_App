//
//  CategoryRequestModel.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

final class CategoryRequestModel: RequestModel {
    
    override var baseURL: String {
        Constant.API.baseURL
    }
    
    override var path: String {
        Constant.API.categoryList
    }
    
    override var method: RequestMethod {
        .get
    }
}
