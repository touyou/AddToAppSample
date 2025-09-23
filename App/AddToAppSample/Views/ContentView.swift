//
//  ContentView.swift
//  AddToAppSample
//
//  Created by 藤井陽介 on 2025/09/21.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant

struct ContentView: View {
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    var body: some View {
        TabView {
            Tab {
                UIViewControllerRepresenter { _ in
                    flutterDependencies.makeFlutterViewController(withInitialRoute: "/")
                }
            } label: {
                Label(title: {
                    Text("Home")
                }, icon: {
                    Image(systemName: "house.fill")
                })
            }
            Tab {
                UIViewControllerRepresenter { _ in
                    flutterDependencies.makeFlutterViewController(withInitialRoute: "/")
                }
            } label: {
                Label(title: {
                    Text("Favorite")
                }, icon: {
                    Image(systemName: "heart.fill")
                })
            }
            Tab {
                UIViewControllerRepresenter { _ in
                    flutterDependencies.makeFlutterViewController(withInitialRoute: "/")
                }
            } label: {
                Label(title: {
                    Text("Search")
                }, icon: {
                    Image(systemName: "magnifyingglass")
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
