//
//  ContentView.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 25/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Divider()
            SampleView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
