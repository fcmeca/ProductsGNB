//
//  Double.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 2/2/23.
//

import Foundation

extension Double {
    var toBankersRounding: Double {
        return (self * 100).rounded(.toNearestOrEven) / 100
    }
}
