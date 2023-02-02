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
        Group{
            if transactionListViewModel.loading {
                CustomProgressView()
            } else{
                NavigationView {
                    List {
                        ForEach(transactionListViewModel.transactions){ transactions in
                            NavigationLink(destination:transactionListViewModel.transactionDetailView(sku: transactions.sku)) {
                                Text("\(transactions.sku)")
                            }
                        }
                        
                    }
                    .navigationTitle("Product List")
                }
            }
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
