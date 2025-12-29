import SwiftUI

struct SymbolColorsSetting: Hashable, Sendable {
    let primaryColor: Color
    let secondaryColor: Color?
    let tertiaryColor: Color?

    init() {
        primaryColor = .primary
        secondaryColor = .blue
        tertiaryColor = .secondary
    }

    init(color: Color) {
        self.primaryColor = color
        self.secondaryColor = nil
        self.tertiaryColor = nil
    }

    init(primaryColor: Color, secondaryColor: Color) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.tertiaryColor = nil
    }

    init(primaryColor: Color, secondaryColor: Color, tertiaryColor: Color) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.tertiaryColor = tertiaryColor
    }
}

extension View {
    @ViewBuilder
    func symbolColors(_ setting: SymbolColorsSetting) -> some View {
        if let secondaryColor = setting.secondaryColor, let tertiaryColor = setting.tertiaryColor {
            foregroundStyle(setting.primaryColor, secondaryColor, tertiaryColor)
        } else if let secondaryColor = setting.secondaryColor {
            foregroundStyle(setting.primaryColor, secondaryColor)
        } else {
            foregroundStyle(setting.primaryColor)
        }
    }
}
