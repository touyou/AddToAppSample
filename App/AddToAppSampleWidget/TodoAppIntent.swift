import WidgetKit
import AppIntents

// このプロジェクトの主眼はApp Intentsの活用ではないため、空にしておく
struct TodoQuery: EntityQuery {
    func entities(for identifiers: [TodoEntity.ID]) async throws -> [TodoEntity] {
        []
    }
    
    func suggestedEntities() async throws -> [TodoEntity] {
        []
    }
    
    func defaultResult() async -> TodoEntity? {
        try? await suggestedEntities().first
    }
}

struct TodoEntity: AppEntity {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Todo"
    static var defaultQuery = TodoQuery()
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }
    
    var item: StorageItem
    
    @ComputedProperty(title: "Identifier")
    var id: String {
        "\(item.id)"
    }
    
    @ComputedProperty(title: "Done or not")
    var isDone: Bool {
        item.isDone
    }
    
    @ComputedProperty(title: "Title")
    var title: String {
        item.title
    }
}

struct TodoAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Todos" }
    static var description: IntentDescription { "Manage your todos." }
    
    @Parameter(title: "Todo items", default: Array<TodoEntity>.init())
    var items: [TodoEntity]
}
