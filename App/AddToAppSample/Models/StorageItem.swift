import SwiftUI

struct StorageItem: Codable {
    let id: Int64
    let title: String
    let isDone: Bool
    let isFavorite: Bool
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
