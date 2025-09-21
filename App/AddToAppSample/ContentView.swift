//
//  ContentView.swift
//  AddToAppSample
//
//  Created by 藤井陽介 on 2025/09/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Flutter") {
                FlutterViewControllerRepresentable()
            }
        }
    }
}

#Preview {
    ContentView()
}
