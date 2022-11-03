//
//  HomePageViewModel.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import Foundation

protocol HomePageViewModelInput {
    var output: HomePageViewModelOutput? {get set}
    
    func viewDidLoad()
    func retrieveCategoryList()
    func retrieveFilteredList()
    func retrieveChefList()
}
protocol HomePageViewModelOutput: AnyObject{
    func home(_home viewModel: HomePageViewModelInput, categoryListDidLoad: [Category])
    func home(_home viewModel: HomePageViewModelInput, filteredCategoryListDidLoad: [FilteredList])
    func home(_home viewModel: HomePageViewModelInput, chefListDidLoad: [FilteredList])
}

final class HomePageViewModel: HomePageViewModelInput {
    var output: HomePageViewModelOutput?
    
    private let categoryAPI: CategoryFetchable
    private let filteredCategoryAPI: FilteredCategoryFetchable
    
    var categoryList: [Category] = []
    var filteredList: [FilteredList] = []
    var chefList: [FilteredList] = []
    
    init(categoryAPI: CategoryAPI, filteredCategoryAPI: FilteredCategoryAPI) {
        self.categoryAPI = categoryAPI
        self.filteredCategoryAPI = filteredCategoryAPI
    }
    func viewDidLoad() {
        retrieveCategoryList()
    }
    func retrieveCategoryList() {
        LoadingManager.shared.show()
        categoryAPI.retrieveCategory(request: .init()) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let categoryList):
                self.categoryList.append(contentsOf: categoryList.categories)
                self.output?.home(_home: self, categoryListDidLoad: categoryList.categories)
                self.retrieveFilteredList()
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    func retrieveFilteredList() {
        LoadingManager.shared.show()
        filteredCategoryAPI.retrieveFilteredList(request: .init(categoryTitle: "Seafood")) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let filteredList):
                self.filteredList.append(contentsOf: filteredList.meals)
                self.output?.home(_home: self, filteredCategoryListDidLoad: filteredList.meals)
                self.retrieveChefList()
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    func retrieveChefList() {
        LoadingManager.shared.show()
        filteredCategoryAPI.retrieveFilteredList(request: .init(categoryTitle: "Pasta")) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let chefList):
                self.chefList.append(contentsOf: chefList.meals)
                self.output?.home(_home: self, chefListDidLoad: chefList.meals)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    
    
}
