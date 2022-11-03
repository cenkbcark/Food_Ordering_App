//
//  DetailPageViewController.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 31.10.2022.
//

import UIKit
import ProgressHUD

final class DetailPageViewController: UIViewController {
    
    @IBOutlet weak private var foodImageView: UIImageView!
    @IBOutlet weak private var foodDescriptionLbl: UILabel!
    @IBOutlet weak private var foodNameLbl: UILabel!
    @IBOutlet weak private var foodAreLbl: UILabel!
    @IBOutlet weak private var buttonStyle: UIButton!
    
    private var viewModel: DetailPageViewModelInput
    private var selectedCategory: FilteredList?
    private var selectedFood: [FoodResponse]?
    private var selectedMeal : FoodResponse?
    
    init(viewModel: DetailPageViewModelInput, selectedCategory: FilteredList) {
        self.viewModel = viewModel
        self.selectedCategory = selectedCategory
        super.init(nibName: "DetailPageViewController", bundle: .main)
        self.viewModel.output = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        buttonStyle.layer.cornerRadius = 15
    }
    
    private func setFood(from meal: [FoodResponse]) {
        for item in meal {
            DispatchQueue.main.async {
                self.selectedMeal = item
                self.foodNameLbl.text = item.strMeal
                self.foodDescriptionLbl.text = item.strInstructions
                self.foodAreLbl.text = item.strArea
                self.foodImageView.sd_setImage(with: URL(string: item.strMealThumb!))
            }
        }
    }

    @IBAction func placeOrderButtonClicked(_ sender: Any) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        selectedMeal?.strCategory = dateFormatter.string(from: date)
        guard let meal = selectedMeal else { return }
        CardCollection.shared.orderedFoodList.append(meal)
        ProgressHUD.showSuccess("Your order has been received..👩🏻‍🍳👨🏻‍🍳🧑🏻‍🍳")
    }
}

extension DetailPageViewController: DetailPageViewModelOutput {
    func home(_home viewModel: DetailPageViewModelInput, selectedFoodDidLoad: MealResponse) {
        self.selectedFood = selectedFoodDidLoad.meals
        setFood(from: self.selectedFood!)
    }
}
