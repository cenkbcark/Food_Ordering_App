//
//  PopularTableViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import UIKit

final class PopularTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    private var filteredList: [FilteredList] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCatergoryCell()
    }
    private func registerCatergoryCell() {
        let cellIdentifier = String(describing: PopularCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [FilteredList]) {
        self.filteredList = model
        collectionView.reloadData()
    }
    
}
extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell {
            cell.setChefCell(from: filteredList[indexPath.row])
            cell.configureCell(from: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let mealApi = MealAPI(networkManager: networkManager)
        let detailViewModel = DetailPageViewModel(mealAPI: mealApi, selectedFood: filteredList[indexPath.row])
        let vc = DetailPageViewController(viewModel: detailViewModel, selectedCategory: filteredList[indexPath.row])
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
