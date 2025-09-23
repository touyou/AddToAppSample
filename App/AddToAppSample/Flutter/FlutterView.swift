import SwiftUI
import FlutterPluginRegistrant

struct FlutterView: View {
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    let initialRoute: String
    
    init(initialRoute: String) {
        self.initialRoute = initialRoute
    }
    
    var body: some View {
        UIViewControllerRepresenter { _ in
            flutterDependencies.makeFlutterViewController(withInitialRoute: initialRoute)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
