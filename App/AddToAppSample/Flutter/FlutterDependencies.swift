import SwiftUI
import Observation
import Flutter
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
    private let flutterEngineGroup = FlutterEngineGroup(name: "flutter engine", project: nil)
    @ObservationIgnored lazy var taskPresenter: TaskPresenter = {
        TaskPresenter(
            onUpdateItems: { [weak self] in
                guard let self else { return }
                self.flutterApis.forEach { api in
                    api.onItemsUpdated(completion: { result in
                        switch result {
                        case .success:
                            break
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                }
            },
            onUpdateSearchQuery: { [weak self] query in
                guard let self else { return }
                self.flutterApis.forEach { api in
                    api.onSearchQueryChanged(query: query, completion: { result in
                        switch result {
                        case .success:
                            break
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                }
            }
        )
    }()
    var flutterApis: [TaskFlutterApi]
    
    init() {
        self.flutterApis = []
    }
    
    func makeFlutterViewController(withInitialRoute initialRoute: String, entryPoint: String = "main") -> FlutterViewController {
        let engine = flutterEngineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: nil, initialRoute: initialRoute)
        GeneratedPluginRegistrant.register(with: engine)
        TaskHostApiSetup.setUp(binaryMessenger: engine.binaryMessenger, api: taskPresenter)
        flutterApis.append(TaskFlutterApi(binaryMessenger: engine.binaryMessenger))
        return FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    }
}

