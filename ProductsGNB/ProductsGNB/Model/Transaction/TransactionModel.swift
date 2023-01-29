//
//  TransactionModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 29/1/23.
//

import Foundation

struct Transaction: Codable, Equatable{
    let sku: String
    let amount: String
    let currency: String
}
