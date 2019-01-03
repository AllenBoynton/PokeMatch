////
////  DesignableImageViews.swift
////  PokeMatch
////
////  Created by Allen Boynton on 5/23/17.
////  Copyright © 2017 Allen Boynton. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable class DesignableImageViews: UIImageView {
//
//    @IBInspectable var cornerRadius: CGFloat = 0.0 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//        }
//    }
//
//    @IBInspectable var borderWidth: CGFloat = 0.0 {
//        didSet {
//            self.layer.borderWidth = borderWidth
//        }
//    }
//
//    @IBInspectable var borderColor: UIColor = .clear {
//        didSet {
//            self.layer.borderColor = borderColor.cgColor
//        }
//    }
//
//    @IBInspectable var masksToBounds: Bool = false {
//        didSet {
//            self.layer.masksToBounds = masksToBounds
//        }
//    }
//}
//
//extension UIImage {
//    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(
//            CGSize(width: self.size.width + insets.left + insets.right,
//                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
//        let _ = UIGraphicsGetCurrentContext()
//        let origin = CGPoint(x: insets.left, y: insets.top)
//        self.draw(at: origin)
//        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return imageWithInsets
//    }
//}
