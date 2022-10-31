//
//  CategoriesCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var categoryImageView: UIImageView!
    @IBOutlet weak private var categoryNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCategory(from category: Category) {
        categoryImageView.image = UIImage(named: category.strCategory)
        categoryNameLbl.text = category.strCategory
    }
    func configureCell(from cell: CategoriesCollectionViewCell){
        cell.layer.cornerRadius = 15
    }

    
}
