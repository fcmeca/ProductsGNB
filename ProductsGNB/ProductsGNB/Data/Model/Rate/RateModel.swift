//
//  RateModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 29/1/23.
//

import Foundation

struct RateModel: Codable {
    let from: String
    let to: String
    let rate: Double
}

typealias Rates = [RateModel]
