import SwiftUI
import Flutter

struct ContentView: View {
    @Environment(FlutterDependencies.self) var flutterDependencies
    @Environment(TaskPresenter.self) var taskPresenter: TaskPresenter
    @State private var searchQuery: String = ""
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Favorites", systemImage: "heart.fill") {
                FavoritesView()
            }
            Tab("Slide", systemImage: "inset.filled.rectangle.and.person.filled") {
                SlideView()
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                NavigationStack {
                    SearchView()
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery) {
            try! taskPresenter.updateSearchQuery(searchQuery)
        }
    }
}

#Preview {
    ContentView()
}
