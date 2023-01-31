//
//  TransactionListRouter.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 31/1/23.
//


import SwiftUI

final class TransactionListRouter {
    
    static func view() -> TransactionListView {
        
        let router = TransactionListRouter()
        let service = TransactionService()
        let viewModel = TransactionListViewModel(router: router, service: service)
        let view = TransactionListView(transactionListViewModel: viewModel)

        return view
    }
}
