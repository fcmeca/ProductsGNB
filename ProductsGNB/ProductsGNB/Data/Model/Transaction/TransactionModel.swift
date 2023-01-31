//
//  TransactionModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 29/1/23.
//

import Foundation

struct TransactionModel: Codable, Identifiable{
    var id = UUID()
    let sku: String
    let amount: Double
    let currency: Currency
    
    enum CodingKeys: String, CodingKey {
            case sku, amount, currency
        }
    
    
}

enum Currency: String, Codable {
    case aud = "AUD"
    case cad = "CAD"
    case eur = "EUR"
    case gbp = "GBP"
    case inr = "INR"
    case jpy = "JPY"
    case rub = "RUB"
    case sek = "SEK"
    case usd = "USD"
}


extension TransactionModel: Equatable {
    static func ==(lhs: TransactionModel, rhs: TransactionModel) -> Bool {
        //Logic that determines whether the value
        //on the left hand side and right hand side are equal
        return lhs.sku == rhs.sku
      }
}


