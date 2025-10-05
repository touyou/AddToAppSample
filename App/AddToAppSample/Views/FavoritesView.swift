import SwiftUI

struct FavoritesView: View {
    @Environment(TaskPresenter.self) private var presenter: TaskPresenter
    
    var body: some View {
        @Bindable var presenter = presenter
        let favoritesPath = Binding<[NavigationDestination]>(
            get: { presenter.path[.favorites] ?? [] },
            set: { presenter.path[.favorites] = $0 }
        )
        NavigationStack(path: favoritesPath) {
            FlutterView(initialRoute: "/favorites")
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .detail(let id):
                        DetailView(id: id)
                    }
                }
        }
    }
}
