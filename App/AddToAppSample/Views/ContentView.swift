//
//  ContentView.swift
//  AddToAppSample
//
//  Created by 藤井陽介 on 2025/09/21.
//

import SwiftUI
import Flutter

struct ContentView: View {
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Favorites", systemImage: "heart.fill") {
                FavoritesView()
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                SearchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
