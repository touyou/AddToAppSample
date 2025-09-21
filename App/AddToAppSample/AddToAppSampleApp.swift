//
//  AddToAppSampleApp.swift
//  AddToAppSample
//
//  Created by 藤井陽介 on 2025/09/21.
//

import SwiftUI

@main
struct AddToAppSampleApp: App {
    @State var flutterDependencies = FlutterDependencies()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(flutterDependencies)
        }
    }
}
