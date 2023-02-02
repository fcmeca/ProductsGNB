//
//  TransactionDetailRouter.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 1/2/23.
//

import SwiftUI

final class TransactionDetailRouter {
    
    static func view(sku: String, transactions: [TransactionModel]) -> TransactionDetailView{
        
        let router = TransactionDetailRouter()
        let service = RateService()
        let viewModel = TransactionDetailViewModel(router: router, ratesService: service, sku: sku, allTransactions: transactions)
        let view = TransactionDetailView(transactionDetailViewModel: viewModel)

        return view
    }
}
