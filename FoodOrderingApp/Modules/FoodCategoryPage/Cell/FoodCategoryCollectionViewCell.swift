//
//  FoodCategoryCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 31.10.2022.
//

import UIKit

final class FoodCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var foodNameLbl: UILabel!
    @IBOutlet weak private var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setFood(from category: FilteredList) {
        foodNameLbl.text = category.strMeal
        foodImageView.sd_setImage(with: URL(string: category.strMealThumb))
        foodImageView.layer.cornerRadius = 15
    }
    func configureCell(from cell: FoodCategoryCollectionViewCell) {
        cell.layer.cornerRadius = 15
    }
}
