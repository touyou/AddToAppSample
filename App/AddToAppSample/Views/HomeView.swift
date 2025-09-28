import SwiftUI

struct HomeView: View {
    @Environment(TaskPresenter.self) private var presenter: TaskPresenter
    
    var body: some View {
        @Bindable var presenter = presenter
        FlutterView(initialRoute: "/")
            .sheet(isPresented: $presenter.showAddSheet) {
                AddView()
            }
    }
}
