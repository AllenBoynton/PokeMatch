//
//  PokeViewCell.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
//import SwiftGifOrigin

class PokeViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    var card: Card? {
        didSet {
            guard let card = card else { return }
            frontImageView.image = card.image
        }
    }
    
    fileprivate(set) var shown: Bool = false
    
    // MARK: - Methods
    
    func showCard(_ show: Bool, animated: Bool) {
        frontImageView.isHidden = false
        backImageView.isHidden = false
        shown = show
        
        //        let left = UIImage(named: "_254")
        //        leftImageView = UIImageView(image: left)
        //
        //        let right = UIImage(named: "_6")
        //        rightImageView = UIImageView(image: right)
        
        if animated {
            if show {
                UIView.transition(from: backImageView,
                                  to: frontImageView,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft, .showHideTransitionViews],
                                  completion: { (finished: Bool) -> () in
                })
            } else {
                UIView.transition(from: frontImageView,
                                  to: backImageView,
                                  duration: 0.5,
                                  options: [.transitionFlipFromRight, .showHideTransitionViews],
                                  completion:  { (finished: Bool) -> () in
                })
            }
        } else {
            if show {
                bringSubviewToFront(frontImageView)
                backImageView.isHidden = true
            } else {
                bringSubviewToFront(backImageView)
                frontImageView.isHidden = true
            }
        }
    }
}
