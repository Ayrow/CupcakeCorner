//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Aymeric Pilaert on 06/03/2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $order.orderStruct.name)
                    TextField("Street Address", text: $order.orderStruct.streetAddress)
                    TextField("City", text: $order.orderStruct.city)
                    TextField("Zip", text: $order.orderStruct.zip)
                }
                
                Section {
                    NavigationLink {
                        CheckoutView(order: order)
                    } label: {
                        Text("Checkout")
                    }
                }
                .disabled(order.orderStruct.hasValidAddress == false)
            }
            
            .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
