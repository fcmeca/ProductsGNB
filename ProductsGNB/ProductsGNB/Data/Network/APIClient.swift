//
//  APIClient.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 30/1/23.
//

import Foundation
import Combine

protocol APIClient {
    
    var session: URLSession { get }
    
    func execute<T: Decodable>(_ request: URLRequest, decodingType: T.Type, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, NetworkErrors>
}

extension APIClient {
    
    func buildURLRequest(with path: String, httpMethod: HTTPMethod) -> URLRequest {
        let url = URL(string: "\(Constants.urlBase)\(path)")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = ["Accept": "application/json"]
        
        return urlRequest
    }
    
    func execute<T: Decodable>(_ request: URLRequest,
                               decodingType: T.Type,
                               queue: DispatchQueue = .main,
                               retries: Int = 0) -> AnyPublisher<T, NetworkErrors>{

        return session.dataTaskPublisher(for: request)
            .mapError{ error -> NetworkErrors in
                if error.errorCode == -1001{
                    return .timeout(error.localizedDescription)
                }else{
                    return .general(error.localizedDescription)
                }
            }
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse else {
                    throw NetworkErrors.badConnection("Connection error")
                }
                if response.statusCode == 200{
                    return $0.data
                }else{
                    throw NetworkErrors.notFound("Not found with code \(response.statusCode)")
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ error -> NetworkErrors in
                if let decodingError = error as? DecodingError{
                    return .decoding(decodingError.localizedDescription)
                }else{
                    return .general(error.localizedDescription)
                }
            }
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()

        }
    
}

enum NetworkErrors: Error {
    case general(String)
    case notFound(String)
    case timeout(String)
    case badConnection(String)
    case decoding(String)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
