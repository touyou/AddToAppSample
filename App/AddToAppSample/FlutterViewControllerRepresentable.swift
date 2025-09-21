import SwiftUI
import Flutter

struct FlutterViewControllerRepresentable: UIViewControllerRepresentable {
    @Environment(FlutterDependencies.self) var flutterDependencies
    
    func makeUIViewController(context: Context) -> some UIViewController {
        FlutterViewController(
            engine: flutterDependencies.flutterEngine,
            nibName: nil,
            bundle: nil,
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
