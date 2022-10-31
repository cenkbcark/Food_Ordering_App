//
//  CategoryPageViewController.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 31.10.2022.
//

import UIKit

final class CategoryPageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: CategoryPageViewModelInput
    private var filteredList: [FilteredList] = []
    private var selectedCategory: Category?
    
    init(viewModel: CategoryPageViewModelInput, selectedCategory: Category) {
        self.viewModel = viewModel
        self.selectedCategory = selectedCategory
        super.init(nibName: "CategoryPageViewController", bundle: .main)
        self.viewModel.output = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCatergoryCell()
        viewModel.viewDidLoad()
        
    }
    private func registerCatergoryCell() {
        let cellIdentifier = String(describing: FoodCategoryCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
extension CategoryPageViewController: CategoryPageViewModelOutput {
    func home(_home viewModel: CategoryPageViewModelInput, categoryListDidLoad: [FilteredList]) {
        filteredList = categoryListDidLoad
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension CategoryPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCollectionViewCell", for: indexPath) as! FoodCategoryCollectionViewCell
        cell.setFood(from: filteredList[indexPath.row])
        cell.configureCell(from: cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let mealApi = MealAPI(networkManager: networkManager)
        let detailViewModel = DetailPageViewModel(mealAPI: mealApi, selectedFood: filteredList[indexPath.row])
        let vc = DetailPageViewController(viewModel: detailViewModel, selectedCategory: filteredList[indexPath.row])
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
        
    }
}
