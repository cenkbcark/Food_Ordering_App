//
//  OnBoardingViewController.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 2.11.2022.
//

import UIKit

final class OnBoardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var slides : [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        slides = [
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.", image: "slide1"),
            OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: "slide2"),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: "slide3")
        ]
        
        registerSlideCell()
        pageControl.numberOfPages = slides.count
        nextButton.layer.cornerRadius = 10
    }
    private func registerSlideCell() {
        let cellIdentifier = String(describing: OnBoardingCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let networkManager = NetworkManager(session: .shared)
            let categoryApi = CategoryAPI(networkManager: networkManager)
            //
            let filteredNetworkManager = NetworkManager(session: .shared)
            let filteredCategoryApi = FilteredCategoryAPI(networkManager: filteredNetworkManager)
            //
            let homeViewModel = HomePageViewModel(categoryAPI: categoryApi, filteredCategoryAPI: filteredCategoryApi)
            let homePageViewController = HomePageViewController(viewModel: homeViewModel)
            //
            let navigationController = UINavigationController(rootViewController: homePageViewController)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.modalTransitionStyle = .flipHorizontal
            present(navigationController, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCollectionViewCell", for: indexPath) as! OnBoardingCollectionViewCell
        cell.setSlides(from: slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
