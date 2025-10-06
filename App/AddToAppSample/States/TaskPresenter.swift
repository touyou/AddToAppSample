import SwiftUI

struct StorageItem: Codable {
    let id: Int64
    let title: String
    let isDone: Bool
    let isFavorite: Bool

    var item: Item {
        Item(id: id, title: title, isDone: isDone, isFavorite: isFavorite)
    }
}

extension [StorageItem]: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let decoded = try? JSONDecoder().decode(Array<StorageItem>.self, from: data)
        else {
            return nil
        }
        self = decoded
    }

    public var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let jsonString = String(data: data, encoding: .utf8)
        else {
            return ""
        }
        return jsonString
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.count != rhs.count {
            return false
        }
        return lhs.enumerated().allSatisfy { (index, item) in item.id == rhs[index].id }
    }
}

enum NavigationDestination: Hashable {
    case detail(Int64)
}

enum Tabs: Equatable, Hashable {
    case home
    case favorites
    case slide
    case native
    case search
}

@MainActor
@Observable
class TaskPresenter: TaskHostApi {
    var showAddSheet: Bool = false
    var tab: Tabs = .home
    var isFiltered: Bool = false

    var path: [Tabs: [NavigationDestination]] = [:]

    @ObservationIgnored
    @AppStorage("items")
    var items: [StorageItem] = []

    @ObservationIgnored
    var onUpdateItems: () -> Void = {}

    @ObservationIgnored
    var onUpdateSearchQuery: (String) -> Void = { _ in }

    init(
        onUpdateItems: @escaping () -> Void,
        onUpdateSearchQuery: @escaping (String) -> Void = { _ in }
    ) {
        self.onUpdateItems = onUpdateItems
        self.onUpdateSearchQuery = onUpdateSearchQuery
        self.path = [
            .home: [],
            .favorites: [],
            .search: [],
        ]
    }

    func addItem(_ title: String) throws {
        let newItem = StorageItem(
            id: Int64.random(in: Int64.min..<Int64.max), title: title, isDone: false,
            isFavorite: false)
        items.append(newItem)
        onUpdateItems()
        showAddSheet = false
    }

    func getItems(completion: @escaping (Result<[Item], any Error>) -> Void) {
        let pigeonItems = items.map(\.item)
        completion(.success(pigeonItems))
    }
    
    func getIsFiltered() throws -> Bool {
        return isFiltered
    }

    func updateSearchQuery(_ query: String) throws {
        onUpdateSearchQuery(query)
    }

    func goToDetail(id: Int64) throws {
        path[tab]?.append(.detail(id))
    }
    
    func toggleFiltered() {
        isFiltered.toggle()
        onUpdateItems()
    }

    func toggleShowAddSheet() throws {
        showAddSheet.toggle()
        onUpdateItems()
    }

    func toggleFavorite(id: Int64, isFavorite: Bool) throws {
        items = items.map { item in
            if item.id == id {
                return StorageItem(
                    id: id, title: item.title, isDone: item.isDone, isFavorite: isFavorite)
            } else {
                return item
            }
        }
        onUpdateItems()
    }

    func toggleDone(id: Int64, isDone: Bool) throws {
        items = items.map { item in
            if item.id == id {
                return StorageItem(
                    id: id, title: item.title, isDone: isDone, isFavorite: item.isFavorite)
            } else {
                return item
            }
        }
        onUpdateItems()
    }
}
