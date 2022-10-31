//
//  PopularCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import UIKit

final class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var foodNameLbl: UILabel!
    @IBOutlet weak private var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setChefCell(from filtered: FilteredList){
        foodNameLbl.text = filtered.strMeal
        foodImageView.layer.cornerRadius = 25
        foodImageView.sd_setImage(with: URL(string: filtered.strMealThumb))
    }
    func configureCell(from cell: PopularCollectionViewCell) {
        cell.layer.cornerRadius = 15
    }
}
