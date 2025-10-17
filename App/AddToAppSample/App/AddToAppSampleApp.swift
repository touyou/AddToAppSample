//
//  AddToAppSampleApp.swift
//  AddToAppSample
//
//  Created by 藤井陽介 on 2025/09/21.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant

@main
struct AddToAppSampleApp: App {
    @State private var flutterDependencies = FlutterDependencies()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(flutterDependencies)
                .environment(flutterDependencies.taskPresenter)
                .colorScheme(.light)
        }
    }
}
