//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Aymeric Pilaert on 06/03/2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmationMessage = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 233)
                    .accessibilityHidden(true)
                    
                    
                    Text("Your total is \(order.orderStruct.cost, format: .currency(code: "USD"))")
                        .font(.title)
                    
                    Button("Place order") {
                        Task {
                            await placeOrder()
                        }
                    }
                    .padding()
                }
                
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you", isPresented: $showingConfirmationMessage) {
                Button("Ok"){ }
            } message: {
                Text(confirmationMessage)
            }
        }

        }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.orderStruct) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "content-Type")
        request.httpMethod = "POST"
        
        do {
            guard let (data, _) = try? await URLSession.shared.upload(for: request, from: encoded) else {
                confirmationMessage = "There is an error placing the order. Please check your network"
                showingConfirmationMessage = true
                return
            }
            
            let decodedOrder = try JSONDecoder().decode(OrderStruct.self, from: data)
            
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(OrderStruct.types[decodedOrder.type].lowercased()) cupcakes is on its way"
                showingConfirmationMessage = true
            
        } catch {
            print("Checkout failed")
        }
        
        
        
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
