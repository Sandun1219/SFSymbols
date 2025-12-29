import Foundation

enum SymbolBackgroundSetting: Identifiable, Hashable, CaseIterable {
    case `default`
    case light
    case dark

    var id: Self {
        self
    }

    var title: LocalizedStringResource {
        switch self {
        case .default:
            "Default"
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }
}
