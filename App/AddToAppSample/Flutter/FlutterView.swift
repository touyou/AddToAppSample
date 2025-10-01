import SwiftUI
import FlutterPluginRegistrant

struct FlutterView: View {
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    let initialRoute: String
    let entryPoint: String?
    
    init(initialRoute: String, entryPoint: String? = nil) {
        self.initialRoute = initialRoute
        self.entryPoint = entryPoint
    }
    
    var body: some View {
        UIViewControllerRepresenter { _ in
            if let entryPoint {
                flutterDependencies.makeFlutterViewController(withInitialRoute: initialRoute, entryPoint: entryPoint)
            } else {
                flutterDependencies.makeFlutterViewController(withInitialRoute: initialRoute)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
