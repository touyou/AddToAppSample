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

extension Array<StorageItem>: @retroactive RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let decoded = try? JSONDecoder().decode(Array<StorageItem>.self, from: data) else {
            return nil
        }
        self = decoded
    }
    
    public var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let jsonString = String(data: data, encoding: .utf8) else {
            return ""
        }
        return jsonString
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        if (lhs.count != rhs.count) {
            return false
        }
        return lhs.enumerated().allSatisfy { (index, item) in item.id == rhs[index].id }
    }
}

@MainActor
@Observable
class TaskPresenter: TaskHostApi {
    var showAddSheet: Bool = false
    
    @ObservationIgnored
    @AppStorage("items")
    var items: [StorageItem] = []
    
    func addItem(_ title: String) throws {
        let newItem = StorageItem(id: Int64.random(in: Int64.min..<Int64.max), title: title, isDone: false, isFavorite: false)
        items.append(newItem)
        showAddSheet = false
    }
    
    func getItems(completion: @escaping (Result<[Item], any Error>) -> Void) {
       let pigeonItems = items.map(\.item)
        completion(.success(pigeonItems))
    }
    
    func toggleShowAddSheet() throws {
        showAddSheet.toggle()
    }
    
    func toggleFavorite(id: Int64, isFavorite: Bool) throws {
        items = items.map { item in
            if item.id == id {
                return StorageItem(id: id, title: item.title, isDone: item.isDone, isFavorite: isFavorite)
            } else {
                return item
            }
        }
    }
    
    func toggleDone(id: Int64, isDone: Bool) throws {
        items = items.map { item in
            if item.id == id {
                return StorageItem(id: id, title: item.title, isDone: isDone, isFavorite: item.isFavorite)
            } else {
                return item
            }
        }
    }
}
