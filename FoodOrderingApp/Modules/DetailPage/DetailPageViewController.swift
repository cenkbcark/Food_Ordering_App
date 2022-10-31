//
//  DetailPageViewController.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 31.10.2022.
//

import UIKit
import ProgressHUD

final class DetailPageViewController: UIViewController {
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodDescriptionLbl: UILabel!
    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var foodAreLbl: UILabel!
    @IBOutlet weak var buttonStyle: UIButton!
    
    private var viewModel: DetailPageViewModelInput
    private var selectedCategory: FilteredList?
    private var selectedFood: [FoodResponse]?
    
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
                self.foodNameLbl.text = item.strMeal
                self.foodDescriptionLbl.text = item.strInstructions
                self.foodAreLbl.text = item.strArea
                self.foodImageView.sd_setImage(with: URL(string: item.strMealThumb!))
            }
        }
    }

    @IBAction func placeOrderButtonClicked(_ sender: Any) {
        ProgressHUD.showSuccess("Your order has been received..👩🏻‍🍳👨🏻‍🍳🧑🏻‍🍳")
    }
}
extension DetailPageViewController: DetailPageViewModelOutput {
    func home(_home viewModel: DetailPageViewModelInput, selectedFoodDidLoad: MealResponse) {
        self.selectedFood = selectedFoodDidLoad.meals
        setFood(from: self.selectedFood!)
    }
}
