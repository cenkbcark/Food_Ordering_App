//
//  OnBoardingCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Cenk Bahadır Çark on 2.11.2022.
//

import UIKit

final class OnBoardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var onboardingSubtitle: UILabel!
    @IBOutlet weak private var onboardingImage: UIImageView!
    @IBOutlet weak private var onboardingTitle: UILabel!
    
    func setSlides(from slide: OnboardingSlide) {
        onboardingImage.image = UIImage(named: slide.image)
        onboardingTitle.text = slide.title
        onboardingSubtitle.text = slide.description
    }

}
