//
//  TransactionListViewModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 31/1/23.
//

import Foundation
import Combine

final class TransactionListViewModel: BaseViewModel {
    
    private let router: TransactionListRouter
    private let transactionService: TransactionService
    var allTransactions: [TransactionModel] = []

    @Published var transactions: [TransactionModel] = []
    
    // Initialization
    init(router: TransactionListRouter, service: TransactionService) {
        self.router = router
        self.transactionService = service
    }
    
    func getTransactions(){
        self.loading = true
        transactionService.getTransactions()
            .sink { completion in
                if case .failure(let error) = completion{
                    switch error{
                        case .general(let error):
                            print(error)
                        case .notFound(let error):
                            print(error)
                        case .timeout(let error):
                            print(error)
                        case .badConnection(let error):
                            print(error)
                        case .decoding(let error):
                            print(error)
                    }
                }
            } receiveValue: {
                self.allTransactions = $0
                var transactionsHelper: [TransactionModel] = []
                $0.forEach { transaction in
                    if !transactionsHelper.contains(transaction){
                        transactionsHelper.append(transaction)
                    }
                    
                }
                self.loading = false
                self.transactions = transactionsHelper
            }
            .store(in: &subscribers)
        
    }
    
    func transactionDetailView(sku: String ) -> TransactionDetailView {
        let transactionsBySku = allTransactions.filter{ $0.sku == sku }
        
        return router.transactionDetailView(sku: sku, allTransactionFromSku: transactionsBySku)
    }
}
