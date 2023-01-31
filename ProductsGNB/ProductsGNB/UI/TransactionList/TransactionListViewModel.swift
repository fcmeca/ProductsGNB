//
//  TransactionListViewModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 31/1/23.
//

import Foundation
import Combine

final class TransactionListViewModel: ObservableObject {
    
    private let router: TransactionListRouter
    private let transactionService: TransactionService
    
    @Published var transactions: [TransactionModel] = []
    
    var subscribers = Set<AnyCancellable>()
    
    // Initialization
    
    init(router: TransactionListRouter, service: TransactionService) {
        self.router = router
        self.transactionService = service
    }
    
    func getTransactions(){
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
                var transactionsHelper: [TransactionModel] = []
                $0.forEach { transaction in
                    if !transactionsHelper.contains(transaction){
                        transactionsHelper.append(transaction)
                    }
                    
                }
                self.transactions = transactionsHelper
            }
            .store(in: &subscribers)
        
    }
    
}
