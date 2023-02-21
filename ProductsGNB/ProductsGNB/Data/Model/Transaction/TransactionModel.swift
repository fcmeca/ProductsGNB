//
//  TransactionModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 29/1/23.
//

import Foundation

struct TransactionModel: Codable, Identifiable{
    let id = UUID()
    let sku: String
    let amount: Double
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case sku, amount, currency
    }
}


extension TransactionModel: Equatable {
    static func ==(lhs: TransactionModel, rhs: TransactionModel) -> Bool {
        //Logic that determines whether the value
        //on the left hand side and right hand side are equal
        return lhs.sku == rhs.sku
    }
}


extension TransactionModel{
    
    
    func convertToEuros(amount: Double, currency: String, conversions: [RateModel]) -> Double? {
        let EUR = "EUR"
        
        if currency == EUR {
            return amount.toBankersRounding
        }else{
            for conversion in conversions {
                if conversion.from == currency {
                    if conversion.to == EUR {
                        return (amount * conversion.rate).toBankersRounding
                    } else {
                        let intermediateResult = convertToEuros(amount: amount, currency: conversion.to, conversions: conversions)
                        if let intermediateResult = intermediateResult {
                            return (intermediateResult * conversion.rate).toBankersRounding
                        }
                    }
                }
            }
        }
        return nil
    }
}

