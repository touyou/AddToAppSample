import SwiftUI
import Flutter
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
    private let flutterEngineGroup = FlutterEngineGroup(name: "flutter engine", project: nil)
    let taskPresenter: TaskPresenter
    var flutterApi: TaskFlutterApi?
    
    init(taskPresenter: TaskPresenter) {
        self.taskPresenter = taskPresenter
        self.flutterApi = nil
    }
    
    func makeFlutterViewController(withInitialRoute initialRoute: String, entryPoint: String = "main") -> FlutterViewController {
        let engine = flutterEngineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: nil, initialRoute: initialRoute)
        GeneratedPluginRegistrant.register(with: engine)
        TaskHostApiSetup.setUp(binaryMessenger: engine.binaryMessenger, api: taskPresenter)
        flutterApi = TaskFlutterApi(binaryMessenger: engine.binaryMessenger)
        return FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    }
}
