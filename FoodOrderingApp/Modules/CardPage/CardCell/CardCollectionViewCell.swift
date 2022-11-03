//
//  CardCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 1.11.2022.
//

import UIKit

final class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var orderImageView: UIImageView!
    @IBOutlet weak private var orderNameLbl: UILabel!
    @IBOutlet weak private var orderDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setFood(from meal: FoodResponse) {
        orderNameLbl.text = meal.strMeal
        guard let image = meal.strMealThumb else { return }
        orderImageView.sd_setImage(with: URL(string: image))
        orderImageView.layer.cornerRadius = 15
        orderDate.text = meal.strCategory
    }
    
    func configureCell(from cell: CardCollectionViewCell){
        cell.layer.cornerRadius = 15
    }

}
