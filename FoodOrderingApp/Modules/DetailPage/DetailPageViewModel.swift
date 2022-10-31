//
//  DetailPageViewModel.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 31.10.2022.
//

import Foundation

protocol DetailPageViewModelInput {
    var output: DetailPageViewModelOutput? {get set}
    var selectedFood: FilteredList? {get set}
    
    func viewDidLoad()
    func retrieveMeal(for meal: FilteredList )
}
protocol DetailPageViewModelOutput: AnyObject {
    func home(_home viewModel: DetailPageViewModelInput, selectedFoodDidLoad: MealResponse)
}

final class DetailPageViewModel: DetailPageViewModelInput {

    var output: DetailPageViewModelOutput?
    private let mealAPI: FilteredMealFetchable
    var selectedFood: FilteredList?
    var filteredFood: [FoodResponse]?
    
    init(mealAPI: FilteredMealFetchable, selectedFood: FilteredList) {
        self.mealAPI = mealAPI
        self.selectedFood = selectedFood
    }
    
    func viewDidLoad() {
        retrieveMeal(for: selectedFood!)
    }
    
    func retrieveMeal(for meal: FilteredList) {
        LoadingManager.shared.show()
        mealAPI.retrieveMeal(request: .init(mealID: meal.idMeal)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let foodResponse):
                self.filteredFood = foodResponse.meals
                self.output?.home(_home: self, selectedFoodDidLoad: foodResponse)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    
}
