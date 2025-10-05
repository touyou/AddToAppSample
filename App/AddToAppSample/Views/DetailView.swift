import SwiftUI

struct DetailView: View {
    let id: Int64
    
    var body: some View {
        FlutterView(initialRoute: "/detail/\(id)")
    }
}
