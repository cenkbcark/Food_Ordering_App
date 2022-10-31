//
//  CategoryTableViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    private var categoryList: [Category] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCatergoryCell()
    }
    
    private func registerCatergoryCell() {
        let cellIdentifier = String(describing: CategoriesCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func prepareCategory(with model: [Category]) {
        self.categoryList = model
        collectionView.reloadData()
    }
}
extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell {
            cell.configureCell(from: cell)
            cell.setCategory(from: categoryList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let categoryApi = FilteredCategoryAPI(networkManager: networkManager)
        let categoryViewModel = CategoryPageViewModel(filteredCategoryAPI: categoryApi, selectedCategory: categoryList[indexPath.row])
        let vc = CategoryPageViewController(viewModel: categoryViewModel, selectedCategory: categoryList[indexPath.row])
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}

