//
//  TransactionListView.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 31/1/23.
//

import SwiftUI

struct TransactionListView: View {
    
    @ObservedObject var transactionListViewModel: TransactionListViewModel

        
    var body: some View {
        NavigationView {
            List {
                ForEach(transactionListViewModel.transactions){ transactions in
                    Text("Product SKU: \(transactions.sku)")
                }
            }
            .navigationTitle("Transaction List: \(transactionListViewModel.transactions.count)")
        }
        .onAppear() {
            transactionListViewModel.getTransactions()
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListRouter.view()
    }
}
