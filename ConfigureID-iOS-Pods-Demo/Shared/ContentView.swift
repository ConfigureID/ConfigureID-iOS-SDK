//
//  ContentView.swift
//  Shared
//
//  Created by Francisco D. on 23/05/2022.
//

import SwiftUI
import ConfigureId

struct ContentView: View {
    var body: some View {
        ConfigureID.Customers.fetchProducts(customerId: 0, onSuccess: { _ in }, onError: { print($0) })
        return Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
