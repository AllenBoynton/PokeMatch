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

class RandomGifs {
    private let gifImages: [UIImage]
    private let flyingGifsSD: [UIImage]
    private let flyingGifsHD: [UIImage]
    
    init() {
        gifImages = [UIImage(gifName: "1.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.gif", levelOfIntegrity: 0.2), UIImage(gifName: "3.gif", levelOfIntegrity: 0.2), UIImage(gifName: "4.gif", levelOfIntegrity: 0.2), UIImage(gifName: "5.gif", levelOfIntegrity: 0.2), UIImage(gifName: "6.gif", levelOfIntegrity: 0.2), UIImage(gifName: "8.gif", levelOfIntegrity: 0.2), UIImage(gifName: "9.gif", levelOfIntegrity: 0.2), UIImage(gifName: "10.gif", levelOfIntegrity: 0.2), UIImage(gifName: "11.gif", levelOfIntegrity: 0.2), UIImage(gifName: "12.gif", levelOfIntegrity: 0.2), UIImage(gifName: "13.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Charizard.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Lugia.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Rayquaza.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Lucario.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Greninja.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Lycanroc_Midday.gif", levelOfIntegrity: 0.2)
        ]
        
        flyingGifsSD = [/*UIImage(gifName: "1.0.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.1.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.2.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.3.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.4.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.5.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.7.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.8.gif", levelOfIntegrity: 0.2), UIImage(gifName: "1.9.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.0.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.1.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.2.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.4.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.5.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.6.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.7.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.8.gif", levelOfIntegrity: 0.2), UIImage(gifName: "2.9.gif", levelOfIntegrity: 0.2), UIImage(gifName: "3.1.gif", levelOfIntegrity: 0.2), UIImage(gifName: "3.2.gif", levelOfIntegrity: 0.2), UIImage(gifName: "3.4.gif", levelOfIntegrity: 0.2), UIImage(gifName: "3.5.gif", levelOfIntegrity: 0.2), UIImage(gifName: "3.6.gif", levelOfIntegrity: 0.2), UIImage(gifName: "3.7.gif", levelOfIntegrity: 0.2), */UIImage(gifName: "Charizard.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Lugia.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Rayquaza.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Hydreigon.gif", levelOfIntegrity: 0.2)
        ]
        
        flyingGifsHD = [UIImage(gifName: "Aerodactyl_Mega.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Alakazam_Mega.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Beedrill_Mega.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Butterfree.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Charizard_MegaX.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Charizard.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Dewgong.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Fearow.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Geodude.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Golbat.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Gyarados_Female.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Haunter.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Magneton.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Moltres.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Pidgeot.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Pidgeotto.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Venomoth.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Victreebel.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Weepinbell.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Zapdos.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Zubat_Female.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Lugia.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Rayquaza.gif", levelOfIntegrity: 0.2), UIImage(gifName: "Hydreigon.gif", levelOfIntegrity: 0.2)
        ]
    }
    
    func randomGif() -> UIImage {
        let unsignedArrayCount = UInt32(gifImages.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
        
        return gifImages[randomNumber]
    }
    
    func randomFlyingGif() -> UIImage {
        let unsignedArrayCount = UInt32(flyingGifsSD.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
        
        return flyingGifsSD[randomNumber]
    }
    
    func randomFlyingGifHD() -> UIImage {
        let unsignedArrayCount = UInt32(flyingGifsHD.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
        
        return flyingGifsHD[randomNumber]
    }
}
