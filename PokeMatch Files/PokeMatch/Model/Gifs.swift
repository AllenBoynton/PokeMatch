//
//  Gifs.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import Foundation
import SwiftyGif
import UIKit

extension PokeMemoryGame : SwiftyGifDelegate {
    
    func gifURLDidFinish(sender: UIImageView) {
        print("gifURLDidFinish")
    }
    
    func gifURLDidFail(sender: UIImageView) {
        print("gifURLDidFail")
    }
    
    func gifDidStart(sender: UIImageView) {
        print("gifDidStart")
    }
    
    func gifDidLoop(sender: UIImageView) {
        print("gifDidLoop")
    }
    
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
    }
}

struct RandomGifs {
    private let gifImages: [UIImage]
    private let flyingGifs: [UIImage]
    
    init() {
        gifImages = [UIImage(gifName: "1.0.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.1.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.2.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.3.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.4.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.5.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.6.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.7.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.8.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.9.gif", levelOfIntegrity:0.15), UIImage(gifName: "2.0.gif", levelOfIntegrity:0.15), UIImage(gifName: "2.gif", levelOfIntegrity:0.15), UIImage(gifName: "3.gif", levelOfIntegrity:0.15), UIImage(gifName: "4.gif", levelOfIntegrity:0.15), UIImage(gifName: "5.gif", levelOfIntegrity:0.15), UIImage(gifName: "6.gif", levelOfIntegrity:0.15), UIImage(gifName: "7.gif", levelOfIntegrity:0.15), UIImage(gifName: "8.gif", levelOfIntegrity:0.15), UIImage(gifName: "9.gif", levelOfIntegrity:0.15), UIImage(gifName: "10.gif", levelOfIntegrity:0.15), UIImage(gifName: "11.gif", levelOfIntegrity:0.15), UIImage(gifName: "12.gif", levelOfIntegrity:0.15), UIImage(gifName: "13.gif", levelOfIntegrity:0.15), UIImage(gifName: "14.gif", levelOfIntegrity:0.15)
        ]
        
        flyingGifs = [UIImage(gifName: "1.0.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.1.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.2.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.3.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.4.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.5.gif", levelOfIntegrity:0.15),UIImage(gifName: "1.6.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.7.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.8.gif", levelOfIntegrity:0.15), UIImage(gifName: "1.9.gif", levelOfIntegrity:0.15), UIImage(gifName: "2.0.gif", levelOfIntegrity:0.15)
        ]
    }
    
    func randomGif() -> UIImage {
        let unsignedArrayCount = UInt32(gifImages.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
        
        return gifImages[randomNumber]
    }
}
