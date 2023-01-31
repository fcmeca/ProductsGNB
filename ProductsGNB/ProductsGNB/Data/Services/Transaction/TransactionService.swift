//
//  TransactionService.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 31/1/23.
//

import Foundation
import Combine

final class TransactionService: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getTransactions() -> AnyPublisher<[TransactionModel], NetworkErrors> {
        return execute(buildURLRequest(with: Constants.pathTransactions, httpMethod: HTTPMethod.get), decodingType: [TransactionModel].self, retries: 3)
    }
}
