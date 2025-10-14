import WidgetKit
import AppIntents
import SwiftUI

struct TodoProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> TodoEntry {
        TodoEntry(date: Date(), todoAppIntent: TodoAppIntent())
    }
    
    func snapshot(for configuration: TodoAppIntent, in context: Context) async -> TodoEntry {
        TodoEntry(date: Date(), todoAppIntent: configuration)
    }
    
    func timeline(for configuration: TodoAppIntent, in context: Context) async -> Timeline<TodoEntry> {
        var entries: [TodoEntry] = []
        
        let defaults = UserDefaults(suiteName: "group.dev.touyou.AddToAppSample")
        
        var storageItems: [StorageItem] = []
        if let data = defaults?.string(forKey: "items") {
            storageItems = .init(rawValue: data) ?? []
        }
        
        let todoEntities: [TodoEntity] = storageItems.map { TodoEntity(item: $0) }
        let intent = TodoAppIntent()
        intent.items = todoEntities
        entries.append(TodoEntry(date: Date(), todoAppIntent: intent))
        
        return Timeline(entries: entries, policy: .never)
    }
}

struct TodoEntry: TimelineEntry {
    let date: Date
    let todoAppIntent: TodoAppIntent
}

struct TodoView: View {
    let item: TodoProvider.Entry
    
    var body: some View {
        VStack(spacing: 16) {
            Text("💡 FlutterKaigi 2025でやること")
                .font(.headline.bold())
            VStack(spacing: 8) {
                ForEach(item.todoAppIntent.items.prefix(3)) { item in
                    HStack(alignment: .center) {
                        Text(item.title)
                        Spacer()
                        Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    }
                }
            }
            Spacer()
        }
    }
}

struct TodoCheckWidget: Widget {
    let kind: String = "todocheck"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: TodoAppIntent.self, provider: TodoProvider()) { entry in
            TodoView(item: entry)
                .containerBackground(.white, for: .widget)
        }
    }
}
