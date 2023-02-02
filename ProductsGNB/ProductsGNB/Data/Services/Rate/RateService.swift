//
//  RateService.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 30/1/23.
//

import Foundation
import Combine

final class RateService: APIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getRates() -> AnyPublisher<[RateModel], NetworkErrors> {
        return execute(buildURLRequest(with: Constants.pathRates, httpMethod: HTTPMethod.get), decodingType: [RateModel].self, retries: 3)
    }
}
