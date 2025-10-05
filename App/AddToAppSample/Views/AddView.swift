import SwiftUI

struct AddView: View {
    enum Field {
        case title
    }
    
    @Environment(FlutterDependencies.self) private var flutterDependencies: FlutterDependencies
    @Environment(TaskPresenter.self) private var presenter: TaskPresenter
    @FocusState private var focusField: Field?
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("TODO")) {
                    TextField("タイトル", text: $title)
                        .focused($focusField, equals: .title)
                }
            }
            .navigationTitle(Text("新規追加"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("閉じる", systemImage: "xmark") {
                        try! presenter.toggleShowAddSheet()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("追加", systemImage: "plus") {
                        try! presenter.addItem(title)
                        try! presenter.updateItemsIfNeeded()
                    }
                    .buttonStyle(.glassProminent)
                    .disabled(title.isEmpty)
                }
            }
            .onAppear {
                focusField = .title
            }
        }
    }
}
