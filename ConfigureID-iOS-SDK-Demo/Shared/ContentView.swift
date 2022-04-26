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
        ProductVisualizerView(url: URL(string: "https://cdn-webgl.fluidconfigure.com/webgl-viewer/examples/demos/model-loading.html")!)
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

    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> UIView {
        return ConfigureID
            .productView(url: url)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
//        uiView.attributedText = text
    }
}