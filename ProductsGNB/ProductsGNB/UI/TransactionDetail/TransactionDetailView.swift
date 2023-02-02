//
//  TransactionDetailView.swift
//  ProductsGNB
//
//  Created by Fran Cazorla on 1/2/23.
//

import SwiftUI

struct TransactionDetailView: View {
    
    @ObservedObject var transactionDetailViewModel: TransactionDetailViewModel
    
    
    var body: some View {
        Group{
            VStack{
                Text("Product SKU:")
                Text("\(transactionDetailViewModel.sku)")
                    .bold()
                List {
                    ForEach(transactionDetailViewModel.allTransactions){ transaction in
                        HStack{
                            Text("\(transaction.amount)")
                            Spacer()
                            Text(transaction.currency)
                        }
                    }
                    
                }
                if transactionDetailViewModel.loading {
                    CustomProgressView()
                } else{
                    Text(String(format: "Total: %.2f EUR", transactionDetailViewModel.total))
                        .font(.system(size: 26))
                        .bold()
                        .padding(20)
                }
            }
            .onAppear() {
                transactionDetailViewModel.getRates()
            }
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailRouter.view(sku: "Name" ,transactions: [TransactionModel(sku: "Product", amount: 1.2, currency: "EUR")])
    }
}
