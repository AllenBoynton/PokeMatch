//
//  PurchaseManager.swift
//  PokeMatch
//
//  Created by Allen Boynton on 11/23/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import StoreKit

class PurchaseManager: NSObject {
    
    private override init() {}
    static let instance = PurchaseManager()
    
    private var productsRequest: SKProductsRequest!
    private var products = [SKProduct]()
    private let paymentQueue = SKPaymentQueue.default()
    
    func fetchProducts() {
        let productsIDs: Set = [IAPProducts.IAP_REMOVE_ADS.rawValue,
                                IAPProducts.IAP_IMAGE_PACK_2.rawValue,
                                IAPProducts.IAP_IMAGE_PACK_3.rawValue,
                                IAPProducts.IAP_IMAGE_PACK_4.rawValue,
                                IAPProducts.IAP_IMAGE_PACK_5.rawValue,
                                IAPProducts.IAP_IMAGE_PACK_6.rawValue,
                                IAPProducts.IAP_IMAGE_PACK_7.rawValue,
                                IAPProducts.IAP_IMAGE_PACK_8.rawValue
                                ]
        productsRequest = SKProductsRequest(productIdentifiers: productsIDs )
        productsRequest.delegate = self
        productsRequest.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProducts) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
}

extension PurchaseManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.products.count > 0 {
            print(response.products.debugDescription)
            products = response.products
        }
    }
}

extension PurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}
