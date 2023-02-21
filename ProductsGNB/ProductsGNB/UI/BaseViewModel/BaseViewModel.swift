//
//  BaseViewModel.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 9/2/23.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    
    @Published var loading = false
    
    var subscribers = Set<AnyCancellable>()

}
