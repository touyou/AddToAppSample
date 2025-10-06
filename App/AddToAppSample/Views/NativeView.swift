import SwiftUI

struct NativeView: View {
    @Environment(TaskPresenter.self) private var presenter: TaskPresenter
    @State private var path: [NavigationDestination] = []
    
    var body: some View {
        @Bindable var presenter = presenter
        NavigationStack(path: $path) {
            List(presenter.items, id: \.id) { item in
                HStack {
                    Text(item.title)
                    Spacer()
                }
                .contentShape(.rect)
                .onTapGesture {
                    path.append(.detail(item.id))
                }
            }
            .navigationTitle("TODO List")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItemGroup {
                    Button("Filter", systemImage: "line.3.horizontal.decrease") {
                        // TODO:
                    }
                }
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
