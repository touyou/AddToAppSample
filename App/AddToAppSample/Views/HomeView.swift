import SwiftUI

struct HomeView: View {
    @Environment(TaskPresenter.self) private var presenter: TaskPresenter
    
    var body: some View {
        @Bindable var presenter = presenter
        let homePath = Binding<[NavigationDestination]>(
            get: { presenter.path[.home] ?? [] },
            set: { presenter.path[.home] = $0 }
        )
        NavigationStack(path: homePath) {
            FlutterView(initialRoute: "/")
                .navigationTitle("TODO List")
                .toolbarTitleDisplayMode(.inlineLarge)
                .toolbar {
                    ToolbarItem {
                        Button("Filter", systemImage: "line.3.horizontal.decrease") {
                            presenter.toggleFiltered()
                        }
                        .closureModifier {
                            if presenter.isFiltered {
                                $0.buttonStyle(.borderedProminent)
                            } else {
                                $0
                            }
                        }
                    }
                }
                .sheet(isPresented: $presenter.showAddSheet) {
                    AddView()
                }
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .detail(let id):
                        DetailView(id: id)
                    }
                }
        }
    }
}

extension View {
    /// Applies a closure to modify the current view.
    /// - Parameter closure: A closure that takes the current view as input and returns a modified view.
    /// - Returns: A view that has been modified by the provided closure.
    public func closureModifier(@ViewBuilder _ closure: (Self) -> some View) -> some View {
        closure(self)
    }
}
