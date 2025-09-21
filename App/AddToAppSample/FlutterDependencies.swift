import SwiftUI
import Flutter
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
    let flutterEngine = FlutterEngine(name: "flutter engine")
    
    init() {
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
    }
}
