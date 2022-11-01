//
//  CardViewController.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 1.11.2022.
//

import UIKit

final class CardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var orderFoodList : [FoodResponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        orderFoodList = CardCollection.shared.orderedFoodList
        registerOrderCell()
        setTitle()

    }
    private func registerOrderCell() {
        let cellIdentifier = String(describing: CardCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    private func setTitle() {
        self.title = "Previous Orders"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderFoodList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell {
            cell.setFood(from: orderFoodList[indexPath.row])
            cell.configureCell(from: cell)
            return cell
        }
        return UICollectionViewCell()
    }
}
//
