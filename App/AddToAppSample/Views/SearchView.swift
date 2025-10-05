import SwiftUI

struct SearchView: View {
    @Environment(TaskPresenter.self) private var presenter: TaskPresenter
    
    var body: some View {
        @Bindable var presenter = presenter
        let searchPath = Binding<[NavigationDestination]>(
            get: { presenter.path[.search] ?? [] },
            set: { presenter.path[.search] = $0 }
        )
        NavigationStack(path: searchPath) {
            FlutterView(initialRoute: "/search")
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .detail(let id):
                        DetailView(id: id)
                    }
                }
        }
    }
}

