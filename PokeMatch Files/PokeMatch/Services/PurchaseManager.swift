//
//  PurchaseManager.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import Foundation
import StoreKit

class PurchaseManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let instance = PurchaseManager()
    
    var productsRequest: SKProductsRequest!
    var products = [SKProduct]()
    
    func fetchProducts() {
        let productsIDs = NSSet(object: IAP_REMOVE_ADS) as! Set<String>
        productsRequest = SKProductsRequest(productIdentifiers: productsIDs)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    let IAP_REMOVE_ADS = "1444497236"
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            print(response.products.debugDescription)
            products = response.products
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
}
