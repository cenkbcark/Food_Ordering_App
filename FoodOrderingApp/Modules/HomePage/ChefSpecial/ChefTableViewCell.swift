//
//  ChefTableViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import UIKit

final class ChefTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var chefList: [FilteredList] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerChefCell()
        
    }
    private func registerChefCell() {
        let cellIdentifier = String(describing: ChefCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [FilteredList]) {
        self.chefList = model
        collectionView.reloadData()
    }

}
extension ChefTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chefList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChefCollectionViewCell", for: indexPath) as? ChefCollectionViewCell {
            cell.setChefCell(from: chefList[indexPath.row])
            cell.configureCell(from: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let mealApi = MealAPI(networkManager: networkManager)
        let detailViewModel = DetailPageViewModel(mealAPI: mealApi, selectedFood: chefList[indexPath.row])
        let vc = DetailPageViewController(viewModel: detailViewModel, selectedCategory: chefList[indexPath.row])
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
