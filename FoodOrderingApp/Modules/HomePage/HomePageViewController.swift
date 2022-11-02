//
//  HomePageViewController.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 30.10.2022.
//

import UIKit

final class HomePageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel: HomePageViewModelInput
    private var categoryList: [Category] = []
    private var filteredList: [FilteredList] = []
    private var chefList: [FilteredList] = []
    private var tabList: [TabList] = []
    
    init(viewModel: HomePageViewModelInput) {
        self.viewModel = viewModel
        super.init(nibName: "HomePageViewController", bundle: .main)
        self.viewModel.output = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCatergoryCell()
        registerPopularCell()
        registerChefCell()
        setUpBarButtonItem()
        viewModel.viewDidLoad()
        
    }
    private func registerCatergoryCell() {
        let cellIdentifier = String(describing: CategoryTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func registerPopularCell() {
        let cellIdentifier = String(describing: PopularTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func registerChefCell() {
        let cellIdentifier = String(describing: ChefTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setUpBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: UIBarButtonItem.Style.done, target: self, action: #selector(cardButtonClicked))
        navigationController?.navigationBar.tintColor = .red
    }
    @objc func cardButtonClicked() {
        let cardVC = CardViewController()
        navigationController?.pushViewController(cardVC, animated: true)
    }
}
extension HomePageViewController: HomePageViewModelOutput {
    func home(_home viewModel: HomePageViewModelInput, categoryListDidLoad: [Category]) {
        tabList.append(.categoryList(categoryListDidLoad))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func home(_home viewModel: HomePageViewModelInput, filteredCategoryListDidLoad: [FilteredList]) {
        tabList.append(.filteredList(filteredCategoryListDidLoad))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func home(_home viewModel: HomePageViewModelInput, chefListDidLoad: [FilteredList]) {
        tabList.append(.chefList(chefListDidLoad))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tabList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabList[section] {
        case .categoryList(_):
            return 1
        case .chefList(_):
            return 1
        case .filteredList(_):
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tabList[indexPath.section]{
        case .categoryList(let categoryList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            cell.prepareCategory(with: categoryList)
            return cell
        case .filteredList(let filteredList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
            cell.prepareCategory(with: filteredList)
            return cell
        case .chefList(let chefList):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChefTableViewCell", for: indexPath) as! ChefTableViewCell
            cell.prepareCategory(with: chefList)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tabList[indexPath.section] {
        case .categoryList(_):
            return 220
        case .filteredList(_):
            return 340
        case .chefList(_):
            return 340

        }
    }
}
enum TabList {
    case categoryList(_ model: [Category])
    case filteredList(_ model: [FilteredList])
    case chefList(_ model: [FilteredList] )
}
