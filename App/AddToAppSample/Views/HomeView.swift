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
                    ToolbarItemGroup {
                        Button("Filter", systemImage: "line.3.horizontal.decrease") {
                            // TODO:
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
