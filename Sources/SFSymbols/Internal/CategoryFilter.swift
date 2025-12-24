import SwiftUI

enum CategoryFilter: Identifiable, Hashable, Sendable {
    case noFilter
    case filter(SFSymbolCategory)

    var id: String {
        switch self {
        case .noFilter:
            "noFilter"
        case .filter(let category):
            "filter:\(category.key)"
        }
    }

    var image: Image {
        switch self {
        case .noFilter:
            Image(systemName: "square.grid.2x2")
        case .filter(let category):
            Image(systemName: category.icon.name)
        }
    }
}
