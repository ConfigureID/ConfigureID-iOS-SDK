//
//  ContentView.swift
//  Shared
//
//  Created by Francisco D. on 21/04/2022.
//

import SwiftUI
import ConfigureID_iOS_SDK

struct ContentView: View {
    var body: some View {
//        Text("Hello, world!")
        ProductVisualizerView()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// TODO: move this inside the package
struct ProductVisualizerView: UIViewRepresentable {
    func makeUIView(context: Context) -> ProductView {
        return ProductView()
    }

    func updateUIView(_ uiView: ProductView, context: Context) {
//        uiView.attributedText = text
    }
}
