import SwiftUI
import Flutter

struct ContentView: View {
    @Environment(FlutterDependencies.self) var flutterDependencies
    @Environment(TaskPresenter.self) var taskPresenter
    @State private var searchQuery: String = ""
    
    var body: some View {
        @Bindable var taskPresenter = taskPresenter
        TabView(selection: $taskPresenter.tab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                HomeView()
            }
            Tab("Favorites", systemImage: "heart.fill", value: .favorites) {
                FavoritesView()
            }
            Tab("Native", systemImage: "swift", value: .native) {
                NativeView()
            }
            Tab("Slide", systemImage: "inset.filled.rectangle.and.person.filled", value: .slide) {
                SlideView()
            }
            Tab("Search", systemImage: "magnifyingglass", value: .search, role: .search) {
                SearchView()
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
