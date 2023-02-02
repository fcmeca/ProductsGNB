//
//  TransactionDetailViewModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 1/2/23.
//

import Foundation
import Combine

final class TransactionDetailViewModel: ObservableObject {
    
    private let router: TransactionDetailRouter
    private let ratesService: RateService
    @Published var sku: String
    @Published var total: Double = 0.0
    @Published var allTransactions: [TransactionModel] = []
    @Published private(set) var loading = false

    var rates: [RateModel] = []
    
    var subscribers = Set<AnyCancellable>()

    init(router: TransactionDetailRouter, ratesService: RateService, sku: String, allTransactions: [TransactionModel]) {
        self.router = router
        self.ratesService = ratesService
        self.sku = sku
        self.allTransactions = allTransactions
    }
    
    func getRates(){
        self.loading = true
        ratesService.getRates()
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
                self.total = 0.0
                self.calculeTotalValue(rates: $0)
                self.loading = false
                
            }
            .store(in: &subscribers)

    }
    
    func calculeTotalValue(rates: [RateModel]){
        allTransactions.forEach {
            if let sum = $0.convertToEuros(amount: $0.amount, currency: $0.currency, conversions: rates){
                self.total += sum
            }
        }
        
    }
}
