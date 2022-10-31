//
//  CategoryPageViewModel.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 31.10.2022.
//

import Foundation

protocol CategoryPageViewModelInput {
    var output: CategoryPageViewModelOutput? {get set}
    var selectedCategory: Category? { get set }
    
    func viewDidLoad()
    func retrieveCategoryList(for category: Category)
}
protocol CategoryPageViewModelOutput: AnyObject {
    func home(_home viewModel: CategoryPageViewModelInput, categoryListDidLoad: [FilteredList])
}

final class CategoryPageViewModel: CategoryPageViewModelInput {
   
    var output: CategoryPageViewModelOutput?
    private let filteredCategoryAPI: FilteredCategoryFetchable
    var filteredList: [FilteredList] = []
    var selectedCategory: Category?
    
    init(filteredCategoryAPI: FilteredCategoryAPI,selectedCategory: Category) {
        self.filteredCategoryAPI = filteredCategoryAPI
        self.selectedCategory = selectedCategory
    }
    
    func viewDidLoad() {
        retrieveCategoryList(for: selectedCategory!)
    }
    func retrieveCategoryList(for category: Category) {
        LoadingManager.shared.show()
        filteredCategoryAPI.retrieveFilteredList(request: .init(categoryTitle: category.strCategory)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let filteredList):
                self.filteredList.append(contentsOf: filteredList.meals)
                self.output?.home(_home: self, categoryListDidLoad: filteredList.meals)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
}
