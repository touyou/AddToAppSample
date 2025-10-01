import SwiftUI
import Flutter
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
    private let flutterEngineGroup = FlutterEngineGroup(name: "flutter engine", project: nil)
    
    func makeFlutterViewController(withInitialRoute initialRoute: String, entryPoint: String = "main") -> FlutterViewController {
        let engine = flutterEngineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: nil, initialRoute: initialRoute)
        GeneratedPluginRegistrant.register(with: engine)
        return FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    }
}
