//
//  PokeMemoryGame.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import Foundation
import UIKit.UIImage
import SwiftyGif
import Darwin

class MemoryGame {
    
    // MARK: - Properties
    var cards: [Card] = [Card]()
    var delegate: GameDelegate?
    var isPlaying: Bool = false
    
    fileprivate var cardsShown: [Card] = [Card]()
    fileprivate var startTime: Date?
    
    // Gets number of cards
    var numberOfCards: Int {
        get {
            return cards.count
        }
    }
    
    // Calculates time passed
    var elapsedTime: TimeInterval {
        get {
            guard startTime != nil else {
                return -1
            }
            return Date().timeIntervalSince(startTime!)
        }
    }
    
    // MARK: - Methods
    
    // Operations to start off a new game
    func newGame(_ cardsData: [UIImage]) {
        cards = randomCards(cardsData)
        startTime = Date.init()
        isPlaying = true
        delegate?.memoryGameDidStart(self)
    }
    
    // Operations when game has been stopped
    func stopGame() {
        isPlaying = false
        cards.removeAll()
        cardsShown.removeAll()
        startTime = nil
    }
    
    // Function to determine shown unpaired and paired cards
    func didSelectCard(_ card: Card?) {
        guard let card = card else { return }
        
        delegate?.memoryGame(self, showCards: [card])
        
        // If cards are not a match
        if unpairedCardShown() {
            let unpaired = unpairedCard()!
            if card.equals(unpaired) {
                cardsShown.append(card)
            } else {
                let unpairedCard = cardsShown.removeLast()
                
                let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: delayTime) {
                    self.delegate?.memoryGame(self, hideCards: [card, unpairedCard])
                }
            }
        } else {
            // If cards are a match
            cardsShown.append(card)
        }
        
        // Adjusts remaining cards. If none -> finish the game
        if cardsShown.count == cards.count {
            finishGame()
        }
    }
    
    // Helps assign cards and adjusts card index
    func cardAtIndex(_ index: Int) -> Card? {
        if cards.count > index {
            return cards[index]
        } else {
            return nil
        }
    }
    
    func indexForCard(_ card: Card) -> Int? {
        for index in 0...cards.count - 1 {
            if card === cards[index] {
                return index
            }
        }
        return nil
    }
    
    // Determines if game is being played and if not...capture time
    fileprivate func finishGame() {
        // Game Over methods
        isPlaying = false
        delegate?.memoryGameDidEnd(self, elapsedTime: elapsedTime)
    }
    
    // Matches cards with same value using remainder
    fileprivate func unpairedCardShown() -> Bool {
        return cardsShown.count % 2 != 0
    }
    
    // Assigns card to be assigned with a match
    fileprivate func unpairedCard() -> Card? {
        let unpairedCard = cardsShown.last
        return unpairedCard
    }
    
    /*************************************** Random Images ***********/
    
    // Pick random cards for game board
    fileprivate func randomCards(_ cardsData:[UIImage]) -> [Card] {
        var cards = [Card]()
        if cardsData.count > 0 {
            for i in 0...cardsData.count - 1 {
                let card = Card.init(image: cardsData[i])
                cards.append(contentsOf: [card, Card.init(card: card)])
            }
        }
        return cards.shuffled()
    }
}

// Mark: - ************** Future gen?CardImages **************
extension MemoryGame {
    // Popular
    static var topCardImages: [UIImage] = [
        UIImage(named: "257")!, UIImage(named:"248")!, UIImage(named:"130")!, UIImage(named: "448")!, UIImage(named: "65")!, UIImage(named: "157")!, UIImage(named: "384")!, UIImage(named: "149")!, UIImage(named: "59")!, UIImage(named: "249")!, UIImage(named: "94")!, UIImage(named: "151")!, UIImage(named: "9")!, UIImage(named: "150")!, UIImage(named: "6")!
    ]
    
    // Gen 1 = 1-151
    static var gen1Images: [UIImage] = [
            UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named:"4")!, UIImage(named: "5")!, UIImage(named: "6")!, UIImage(named: "7")!, UIImage(named:"8")!, UIImage(named: "9")!, UIImage(named: "10")!, UIImage(named: "11")!, UIImage(named: "12")!, UIImage(named: "13")!, UIImage(named: "14")!, UIImage(named: "15")!, UIImage(named: "16")!, UIImage(named: "17")!, UIImage(named: "18")!, UIImage(named: "19")!, UIImage(named: "20")!, UIImage(named: "21")!, UIImage(named: "22")!, UIImage(named: "23")!, UIImage(named: "24")!, UIImage(named: "25")!, UIImage(named: "26")!, UIImage(named: "27")!, UIImage(named: "28")!, UIImage(named: "29")!, UIImage(named: "30")!, UIImage(named: "31")!, UIImage(named: "32")!, UIImage(named: "33")!, UIImage(named: "34")!, UIImage(named: "35")!, UIImage(named: "36")!, UIImage(named: "37")!, UIImage(named: "38")!, UIImage(named: "39")!, UIImage(named: "40")!, UIImage(named: "41")!, UIImage(named: "42")!, UIImage(named: "43")!, UIImage(named: "44")!, UIImage(named: "45")!, UIImage(named: "46")!, UIImage(named: "47")!, UIImage(named: "48")!, UIImage(named: "49")!, UIImage(named: "50")!, UIImage(named: "51")!, UIImage(named: "52")!, UIImage(named: "53")!, UIImage(named: "54")!, UIImage(named: "55")!, UIImage(named: "56")!, UIImage(named: "57")!, UIImage(named: "58")!, UIImage(named: "59")!, UIImage(named: "60")!, UIImage(named: "61")!, UIImage(named: "62")!, UIImage(named: "63")!, UIImage(named: "64")!, UIImage(named: "65")!, UIImage(named: "66")!, UIImage(named: "67")!, UIImage(named: "68")!, UIImage(named: "69")!, UIImage(named: "70")!, UIImage(named: "71")!, UIImage(named: "72")!, UIImage(named: "73")!, UIImage(named: "74")!, UIImage(named: "75")!, UIImage(named: "76")!, UIImage(named: "77")!, UIImage(named: "78")!, UIImage(named: "79")!, UIImage(named: "80")!, UIImage(named: "81")!, UIImage(named: "82")!, UIImage(named: "83")!, UIImage(named: "84")!, UIImage(named: "85")!, UIImage(named: "86")!, UIImage(named: "87")!, UIImage(named: "88")!, UIImage(named: "89")!, UIImage(named: "90")!, UIImage(named: "91")!, UIImage(named: "92")!, UIImage(named: "93")!, UIImage(named: "94")!, UIImage(named: "95")!, UIImage(named: "96")!, UIImage(named: "97")!, UIImage(named: "98")!, UIImage(named: "99")!, UIImage(named: "100")!, UIImage(named: "101")!, UIImage(named: "102")!, UIImage(named: "103")!, UIImage(named: "104")!, UIImage(named: "105")!, UIImage(named: "106")!, UIImage(named: "107")!, UIImage(named: "108")!, UIImage(named: "109")!, UIImage(named: "110")!, UIImage(named: "111")!, UIImage(named: "112")!, UIImage(named: "113")!, UIImage(named: "114")!, UIImage(named: "115")!, UIImage(named: "116")!, UIImage(named: "117")!, UIImage(named: "118")!, UIImage(named: "119")!, UIImage(named: "120")!, UIImage(named: "121")!, UIImage(named: "122")!, UIImage(named: "123")!, UIImage(named: "124")!, UIImage(named: "125")!, UIImage(named: "126")!, UIImage(named: "127")!, UIImage(named: "128")!, UIImage(named: "129")!, UIImage(named: "130")!, UIImage(named: "131")!, UIImage(named: "132")!, UIImage(named: "133")!, UIImage(named: "134")!, UIImage(named: "135")!, UIImage(named: "136")!, UIImage(named: "137")!, UIImage(named: "138")!, UIImage(named: "139")!, UIImage(named: "140")!, UIImage(named: "141")!, UIImage(named: "142")!, UIImage(named: "143")!, UIImage(named: "144")!, UIImage(named: "145")!, UIImage(named: "146")!, UIImage(named: "147")!, UIImage(named: "148")!, UIImage(named: "149")!, UIImage(named: "150")!, UIImage(named: "151")!
    ]
    
    // Gen 2 = 152-251
    static var gen2Images: [UIImage] = [
            UIImage(named: "152")!, UIImage(named:"153")!, UIImage(named: "154")!, UIImage(named: "155")!, UIImage(named: "156")!, UIImage(named: "157")!, UIImage(named: "158")!, UIImage(named: "159")!, UIImage(named: "160")!, UIImage(named: "161")!, UIImage(named: "162")!, UIImage(named: "163")!, UIImage(named: "164")!, UIImage(named: "165")!, UIImage(named: "166")!, UIImage(named: "167")!, UIImage(named: "168")!, UIImage(named: "169")!, UIImage(named: "170")!, UIImage(named: "171")!, UIImage(named: "172")!, UIImage(named: "173")!, UIImage(named: "174")!, UIImage(named: "175")!, UIImage(named: "176")!, UIImage(named: "177")!, UIImage(named: "178")!, UIImage(named: "179")!, UIImage(named: "180")!, UIImage(named: "181")!, UIImage(named: "182")!, UIImage(named: "183")!, UIImage(named: "184")!, UIImage(named: "185")!, UIImage(named: "186")!, UIImage(named: "187")!, UIImage(named: "188")!, UIImage(named: "189")!, UIImage(named: "190")!, UIImage(named: "191")!, UIImage(named: "192")!, UIImage(named: "193")!, UIImage(named: "194")!, UIImage(named: "195")!, UIImage(named: "196")!, UIImage(named: "197")!, UIImage(named: "198")!, UIImage(named: "199")!, UIImage(named: "200")!, UIImage(named: "201")!, UIImage(named: "202")!, UIImage(named: "203")!, UIImage(named: "204")!, UIImage(named: "205")!, UIImage(named: "206")!, UIImage(named: "207")!, UIImage(named: "208")!, UIImage(named: "209")!, UIImage(named: "210")!, UIImage(named: "211")!, UIImage(named: "212")!, UIImage(named: "213")!, UIImage(named: "214")!, UIImage(named: "215")!, UIImage(named: "216")!, UIImage(named: "127")!, UIImage(named: "218")!, UIImage(named: "219")!, UIImage(named: "220")!, UIImage(named: "221")!, UIImage(named: "222")!, UIImage(named: "223")!, UIImage(named: "224")!, UIImage(named: "225")!, UIImage(named: "226")!, UIImage(named: "227")!, UIImage(named: "228")!, UIImage(named: "229")!, UIImage(named: "230")!, UIImage(named: "231")!, UIImage(named: "232")!, UIImage(named: "233")!, UIImage(named: "234")!, UIImage(named: "235")!, UIImage(named: "236")!, UIImage(named: "237")!, UIImage(named: "238")!, UIImage(named: "239")!, UIImage(named: "240")!, UIImage(named: "241")!, UIImage(named: "242")!, UIImage(named: "243")!, UIImage(named: "244")!, UIImage(named: "245")!, UIImage(named: "246")!, UIImage(named: "247")!, UIImage(named: "248")!, UIImage(named: "249")!, UIImage(named: "250")!, UIImage(named: "251")!
    ]
    
    // Gen 3 = 252-386
    static var gen3Images: [UIImage] = [
        UIImage(named: "252")!, UIImage(named:"253")!, UIImage(named: "254")!, UIImage(named: "255")!, UIImage(named: "256")!, UIImage(named: "257")!, UIImage(named: "258")!, UIImage(named: "259")!, UIImage(named: "260")!, UIImage(named: "261")!, UIImage(named: "262")!, UIImage(named: "263")!, UIImage(named: "264")!, UIImage(named: "265")!, UIImage(named: "266")!, UIImage(named: "267")!, UIImage(named: "268")!, UIImage(named: "269")!, UIImage(named: "270")!, UIImage(named: "271")!, UIImage(named: "272")!, UIImage(named: "273")!, UIImage(named: "274")!, UIImage(named: "275")!, UIImage(named: "276")!, UIImage(named: "277")!, UIImage(named: "278")!, UIImage(named: "279")!, UIImage(named: "280")!, UIImage(named: "281")!, UIImage(named: "282")!, UIImage(named: "283")!, UIImage(named: "284")!, UIImage(named: "285")!, UIImage(named: "286")!, UIImage(named: "287")!, UIImage(named: "288")!, UIImage(named: "289")!, UIImage(named: "290")!, UIImage(named: "291")!, UIImage(named: "292")!, UIImage(named: "293")!, UIImage(named: "294")!, UIImage(named: "295")!//, UIImage(named: "296")!, UIImage(named: "297")!, UIImage(named: "298")!, UIImage(named: "299")!, UIImage(named: "300")!, UIImage(named: "301")!, UIImage(named: "302")!, UIImage(named: "303")!, UIImage(named: "304")!, UIImage(named: "305")!, UIImage(named: "306")!, UIImage(named: "307")!, UIImage(named: "308")!, UIImage(named: "309")!, UIImage(named: "310")!, UIImage(named: "311")!, UIImage(named: "312")!, UIImage(named: "313")!, UIImage(named: "314")!, UIImage(named: "315")!, UIImage(named: "316")!, UIImage(named: "317")!, UIImage(named: "318")!, UIImage(named: "319")!, UIImage(named: "320")!, UIImage(named: "321")!, UIImage(named: "322")!, UIImage(named: "323")!, UIImage(named: "324")!, UIImage(named: "325")!, UIImage(named: "326")!, UIImage(named: "327")!, UIImage(named: "328")!, UIImage(named: "329")!, UIImage(named: "330")!, UIImage(named: "331")!, UIImage(named: "332")!, UIImage(named: "333")!, UIImage(named: "334")!, UIImage(named: "335")!, UIImage(named: "336")!, UIImage(named: "337")!, UIImage(named: "338")!, UIImage(named: "339")!, UIImage(named: "340")!, UIImage(named: "341")!, UIImage(named: "342")!, UIImage(named: "343")!, UIImage(named: "344")!, UIImage(named: "345")!, UIImage(named: "346")!, UIImage(named: "347")!, UIImage(named: "348")!, UIImage(named: "349")!, UIImage(named: "350")!, UIImage(named: "351")!, UIImage(named: "352")!, UIImage(named: "353")!, UIImage(named: "354")!, UIImage(named: "355")!, UIImage(named: "356")!, UIImage(named: "357")!, UIImage(named: "358")!, UIImage(named: "359")!, UIImage(named: "360")!, UIImage(named: "361")!, UIImage(named: "362")!, UIImage(named: "363")!, UIImage(named: "364")!, UIImage(named: "365")!, UIImage(named: "366")!, UIImage(named: "367")!, UIImage(named: "368")!, UIImage(named: "369")!, UIImage(named: "370")!, UIImage(named: "371")!, UIImage(named: "372")!, UIImage(named: "373")!, UIImage(named: "374")!, UIImage(named: "375")!, UIImage(named: "376")!, UIImage(named: "377")!, UIImage(named: "378")!, UIImage(named: "379")!, UIImage(named: "380")!, UIImage(named: "381")!, UIImage(named: "382")!, UIImage(named: "383")!, UIImage(named: "384")!, UIImage(named: "385")!, UIImage(named:" 386")!
    ]
    
    // Gen 4 = 387-493
    static var gen4Images: [UIImage] = [
            UIImage(named: "387")!, UIImage(named: "388")!, UIImage(named: "389")!, UIImage(named:"390")!, UIImage(named: "391")!, UIImage(named: "392")!, UIImage(named: "393")!, UIImage(named: "394")!, UIImage(named: "395")!, UIImage(named: "396")!, UIImage(named: "397")!, UIImage(named: "398")!, UIImage(named: "399")!, UIImage(named: "400")!, UIImage(named: "401")!, UIImage(named: "402")!, UIImage(named: "403")!, UIImage(named: "404")!, UIImage(named: "405")!, UIImage(named: "406")!, UIImage(named: "407")!, UIImage(named: "408")!, UIImage(named: "409")!, UIImage(named: "410")!, UIImage(named: "411")!, UIImage(named: "412")!, UIImage(named: "413")!, UIImage(named: "414")!, UIImage(named: "415")!, UIImage(named: "416")!, UIImage(named: "417")!, UIImage(named: "418")!, UIImage(named: "419")!, UIImage(named: "420")!, UIImage(named: "421")!, UIImage(named: "422")!, UIImage(named: "423")!, UIImage(named: "424")!, UIImage(named: "425")!, UIImage(named: "426")!, UIImage(named: "427")!, UIImage(named: "428")!, UIImage(named: "429")!, UIImage(named: "430")!, UIImage(named: "431")!, UIImage(named: "432")!, UIImage(named: "433")!, UIImage(named: "434")!, UIImage(named: "435")!, UIImage(named: "436")!, UIImage(named: "437")!, UIImage(named: "438")!, UIImage(named: "439")!, UIImage(named: "440")!, UIImage(named: "441")!, UIImage(named: "442")!, UIImage(named: "443")!, UIImage(named: "444")!, UIImage(named: "445")!, UIImage(named: "446")!, UIImage(named: "447")!, UIImage(named: "448")!, UIImage(named: "449")!, UIImage(named: "450")!, UIImage(named: "451")!, UIImage(named: "452")!, UIImage(named: "453")!, UIImage(named: "454")!, UIImage(named: "455")!, UIImage(named: "456")!, UIImage(named: "457")!, UIImage(named: "458")!, UIImage(named: "459")!, UIImage(named: "460")!, UIImage(named: "461")!, UIImage(named: "462")!, UIImage(named: "463")!, UIImage(named: "464")!, UIImage(named: "465")!, UIImage(named: "466")!, UIImage(named: "467")!, UIImage(named: "468")!, UIImage(named: "469")!, UIImage(named: "470")!, UIImage(named: "471")!, UIImage(named: "472")!, UIImage(named: "473")!, UIImage(named: "474")!, UIImage(named: "475")!, UIImage(named: "476")!, UIImage(named: "477")!, UIImage(named: "478")!, UIImage(named: "479")!, UIImage(named: "480")!, UIImage(named: "481")!, UIImage(named: "482")!, UIImage(named: "483")!, UIImage(named: "484")!, UIImage(named: "485")!, UIImage(named: "486")!, UIImage(named: "487")!, UIImage(named: "488")!, UIImage(named: "489")!, UIImage(named: "490")!, UIImage(named: "491")!, UIImage(named: "492")!, UIImage(named: "493")!
    ]
    
    // Gen 5 = 494-649
    static var gen5Images: [UIImage] = [
            UIImage(named:"494")!, UIImage(named: "495")!, UIImage(named: "496")!, UIImage(named: "497")!, UIImage(named: "498")!, UIImage(named: "499")!, UIImage(named: "500")!, UIImage(named: "501")!, UIImage(named: "502")!, UIImage(named: "503")!, UIImage(named: "504")!, UIImage(named: "505")!, UIImage(named: "506")!, UIImage(named: "507")!, UIImage(named: "508")!, UIImage(named: "509")!, UIImage(named: "510")!, UIImage(named: "511")!, UIImage(named: "512")!, UIImage(named: "513")!, UIImage(named: "514")!, UIImage(named: "515")!, UIImage(named: "516")!, UIImage(named: "517")!, UIImage(named: "518")!, UIImage(named: "519")!, UIImage(named: "520")!, UIImage(named: "521")!, UIImage(named: "522")!, UIImage(named: "523")!, UIImage(named: "524")!, UIImage(named: "525")!, UIImage(named: "526")!, UIImage(named: "527")!, UIImage(named: "528")!, UIImage(named: "529")!, UIImage(named: "530")!, UIImage(named: "531")!, UIImage(named: "532")!, UIImage(named: "533")!, UIImage(named: "534")!, UIImage(named: "535")!, UIImage(named: "536")!, UIImage(named: "537")!, UIImage(named: "538")!, UIImage(named: "539")!, UIImage(named: "540")!, UIImage(named: "541")!, UIImage(named: "542")!, UIImage(named: "543")!, UIImage(named: "544")!, UIImage(named: "545")!, UIImage(named: "546")!, UIImage(named: "547")!, UIImage(named: "548")!, UIImage(named: "549")!, UIImage(named: "550")!, UIImage(named: "551")!, UIImage(named: "552")!, UIImage(named: "553")!, UIImage(named: "554")!, UIImage(named: "555")!, UIImage(named: "556")!, UIImage(named: "557")!, UIImage(named: "558")!, UIImage(named: "559")!, UIImage(named: "560")!, UIImage(named: "561")!, UIImage(named: "562")!, UIImage(named: "563")!, UIImage(named: "564")!, UIImage(named: "565")!, UIImage(named: "566")!, UIImage(named: "567")!, UIImage(named: "568")!, UIImage(named: "569")!, UIImage(named: "570")!, UIImage(named: "571")!, UIImage(named: "572")!, UIImage(named: "573")!, UIImage(named: "574")!, UIImage(named: "575")!, UIImage(named: "576")!, UIImage(named: "577")!, UIImage(named: "578")!, UIImage(named: "579")!, UIImage(named: "580")!, UIImage(named: "581")!, UIImage(named: "582")!, UIImage(named: "583")!, UIImage(named: "584")!, UIImage(named: "585")!, UIImage(named: "586")!, UIImage(named: "587")!, UIImage(named: "588")!, UIImage(named: "589")!, UIImage(named: "590")!, UIImage(named: "591")!, UIImage(named: "592")!, UIImage(named: "593")!, UIImage(named: "594")!, UIImage(named: "595")!, UIImage(named: "596")!, UIImage(named: "597")!, UIImage(named: "598")!, UIImage(named: "599")!, UIImage(named: "600")!, UIImage(named: "601")!, UIImage(named: "602")!, UIImage(named: "603")!, UIImage(named: "604")!, UIImage(named: "605")!, UIImage(named: "606")!, UIImage(named: "607")!, UIImage(named: "608")!, UIImage(named: "609")!, UIImage(named: "610")!, UIImage(named: "611")!, UIImage(named: "612")!, UIImage(named: "613")!, UIImage(named: "614")!, UIImage(named: "615")!, UIImage(named: "616")!, UIImage(named: "617")!, UIImage(named: "618")!, UIImage(named: "169")!, UIImage(named: "620")!, UIImage(named: "621")!, UIImage(named: "622")!, UIImage(named: "623")!, UIImage(named: "624")!, UIImage(named: "625")!, UIImage(named: "626")!, UIImage(named: "627")!, UIImage(named: "628")!, UIImage(named: "629")!, UIImage(named: "630")!, UIImage(named: "631")!, UIImage(named: "632")!, UIImage(named: "633")!, UIImage(named: "634")!, UIImage(named: "635")!, UIImage(named: "636")!, UIImage(named: "637")!, UIImage(named: "638")!, UIImage(named: "639")!, UIImage(named: "640")!, UIImage(named: "641")!, UIImage(named: "642")!, UIImage(named: "643")!, UIImage(named: "644")!, UIImage(named: "645")!, UIImage(named: "646")!, UIImage(named: "647")!, UIImage(named: "648")!, UIImage(named: "649")!
    ]
    
    // Gen 6 = 650-721
    static var gen6Images: [UIImage] = [
            UIImage(named: "650")!, UIImage(named: "651")!, UIImage(named: "652")!, UIImage(named:"653")!, UIImage(named: "654")!, UIImage(named: "655")!, UIImage(named: "656")!, UIImage(named: "657")!, UIImage(named: "658")!, UIImage(named: "659")!, UIImage(named: "660")!, UIImage(named: "661")!, UIImage(named: "662")!, UIImage(named: "663")!, UIImage(named: "664")!, UIImage(named: "665")!, UIImage(named: "666")!, UIImage(named: "667")!, UIImage(named: "668")!, UIImage(named: "669")!, UIImage(named: "670")!, UIImage(named: "671")!, UIImage(named: "672")!, UIImage(named: "673")!, UIImage(named: "674")!, UIImage(named: "675")!, UIImage(named: "676")!, UIImage(named: "677")!, UIImage(named: "678")!, UIImage(named: "679")!, UIImage(named: "680")!, UIImage(named: "681")!, UIImage(named: "682")!, UIImage(named: "683")!, UIImage(named: "684")!, UIImage(named: "685")!, UIImage(named: "686")!, UIImage(named: "687")!, UIImage(named: "688")!, UIImage(named: "689")!, UIImage(named: "690")!, UIImage(named: "691")!, UIImage(named: "692")!, UIImage(named: "693")!, UIImage(named: "694")!, UIImage(named: "695")!, UIImage(named: "696")!, UIImage(named: "697")!, UIImage(named: "698")!, UIImage(named: "699")!, UIImage(named: "700")!, UIImage(named: "701")!, UIImage(named: "702")!, UIImage(named: "703")!, UIImage(named: "704")!, UIImage(named: "705")!, UIImage(named: "706")!, UIImage(named: "707")!, UIImage(named: "708")!, UIImage(named: "709")!, UIImage(named: "710")!, UIImage(named: "711")!, UIImage(named: "712")!, UIImage(named: "713")!, UIImage(named: "714")!, UIImage(named: "715")!, UIImage(named: "716")!, UIImage(named: "717")!, UIImage(named: "718")!, UIImage(named: "719")!, UIImage(named: "720")!, UIImage(named: "721")!
    ]
    
    // Gen 7 = 722-807
    static var gen7Images: [UIImage] = [
        UIImage(named: "722")!, UIImage(named:"723")!, UIImage(named: "724")!, UIImage(named: "725")!, UIImage(named: "726")!, UIImage(named: "727")!, UIImage(named: "728")!, UIImage(named: "729")!, UIImage(named: "730")!, UIImage(named: "731")!, UIImage(named: "732")!, UIImage(named: "733")!, UIImage(named: "734")!, UIImage(named: "735")!, UIImage(named: "736")!, UIImage(named: "737")!, UIImage(named: "738")!, UIImage(named: "739")!, UIImage(named: "740")!, UIImage(named: "741_1")!, UIImage(named: "741_2")!, UIImage(named: "741_3")!, UIImage(named: "741_4")!, UIImage(named: "742")!, UIImage(named: "743")!, UIImage(named: "744")!, UIImage(named: "745_1")!, UIImage(named: "745_2")!, UIImage(named: "745_3")!, UIImage(named: "746_1")!, UIImage(named: "746_2")!, UIImage(named: "747")!, UIImage(named: "748")!, UIImage(named: "749")!, UIImage(named: "750")!, UIImage(named: "751")!, UIImage(named: "752")!, UIImage(named: "753")!, UIImage(named: "754")!, UIImage(named: "755")!, UIImage(named: "756")!, UIImage(named: "757")!, UIImage(named: "758")!, UIImage(named: "759")!, UIImage(named: "760")!, UIImage(named: "761")!, UIImage(named: "762")!, UIImage(named: "763")!, UIImage(named: "764")!, UIImage(named: "765")!, UIImage(named: "766")!, UIImage(named: "767")!, UIImage(named: "768")!, UIImage(named: "769")!, UIImage(named: "770")!, UIImage(named: "771")!, UIImage(named: "772")!, UIImage(named: "773")!, UIImage(named: "774")!, UIImage(named: "775")!, UIImage(named: "776")!, UIImage(named: "777")!, UIImage(named: "778")!, UIImage(named: "779")!, UIImage(named: "780")!, UIImage(named: "781")!, UIImage(named: "782")!, UIImage(named: "783")!, UIImage(named: "784")!, UIImage(named: "785")!, UIImage(named: "786")!, UIImage(named: "787")!, UIImage(named: "788")!, UIImage(named: "789")!, UIImage(named: "790")!, UIImage(named: "791")!, UIImage(named: "792")!, UIImage(named: "793")!, UIImage(named: "794")!, UIImage(named: "795")!, UIImage(named: "796")!, UIImage(named: "797")!, UIImage(named: "798")!, UIImage(named: "799")!, UIImage(named: "800")!, UIImage(named: "801")!, UIImage(named: "802")!, UIImage(named: "803")!, UIImage(named: "804")!, UIImage(named: "805")!, UIImage(named: "806")!, UIImage(named: "807")!
    ]
}
