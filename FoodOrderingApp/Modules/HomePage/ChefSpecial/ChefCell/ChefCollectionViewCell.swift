//
//  ChefCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import UIKit
import SDWebImage

final class ChefCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var foodImageView: UIImageView!
    @IBOutlet weak private var foodNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setChefCell(from chef: FilteredList){
        foodNameLbl.text = chef.strMeal
        foodImageView.layer.cornerRadius = 25
        foodImageView.sd_setImage(with: URL(string: chef.strMealThumb))
    }
    func configureCell(from cell: ChefCollectionViewCell) {
        cell.layer.cornerRadius = 15
    }
}
