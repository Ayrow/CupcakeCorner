//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Aymeric Pilaert on 06/03/2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        Text("Hello World")

        }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
