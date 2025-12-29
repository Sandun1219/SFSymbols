import SwiftUI

enum BackportedSymbolColorRenderingMode: Hashable, Sendable {
    case flat
    case gradient
}

struct SymbolForegroundStyle: Hashable, Sendable {
    let primaryColor: Color
    let secondaryColor: Color?
    let tertiaryColor: Color?

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

private struct SFSymbolPickerRenderingModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: SymbolRenderingMode = .monochrome
}

extension EnvironmentValues {
    var sfSymbolPickerRenderingMode: SymbolRenderingMode {
        get { self[SFSymbolPickerRenderingModeEnvironmentKey.self] }
        set { self[SFSymbolPickerRenderingModeEnvironmentKey.self] = newValue }
    }
}

private struct SFSymbolPickerColorRenderingModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: BackportedSymbolColorRenderingMode = .flat
}

extension EnvironmentValues {
    var sfSymbolPickerColorRenderingMode: BackportedSymbolColorRenderingMode {
        get { self[SFSymbolPickerColorRenderingModeEnvironmentKey.self] }
        set { self[SFSymbolPickerColorRenderingModeEnvironmentKey.self] = newValue }
    }
}

private struct SFSymbolPickerForegroundStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: SymbolForegroundStyle = SymbolForegroundStyle(
        primaryColor: .primary,
        secondaryColor: .blue,
        tertiaryColor: .secondary
    )
}

extension EnvironmentValues {
    var sfSymbolPickerForegroundStyle: SymbolForegroundStyle {
        get { self[SFSymbolPickerForegroundStyleEnvironmentKey.self] }
        set { self[SFSymbolPickerForegroundStyleEnvironmentKey.self] = newValue }
    }
}

private struct SFSymbolPickerPreviewUsesRenderingModeEnvironmentKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var sfSymbolPickerPreviewUsesRenderingMode: Bool {
        get { self[SFSymbolPickerPreviewUsesRenderingModeEnvironmentKey.self] }
        set { self[SFSymbolPickerPreviewUsesRenderingModeEnvironmentKey.self] = newValue }
    }
}

public extension View {
    @ViewBuilder
    func sfSymbolPickerRenderingMode(_ renderingMode: SymbolRenderingMode) -> some View {
        environment(\.sfSymbolPickerRenderingMode, renderingMode)
    }

    @available(iOS 26, *)
    @ViewBuilder
    func sfSymbolPickerColorRenderingMode(_ colorMode: SymbolColorRenderingMode) -> some View {
        if colorMode == .flat {
            environment(\.sfSymbolPickerColorRenderingMode, .flat)
        } else if colorMode == .gradient {
            environment(\.sfSymbolPickerColorRenderingMode, .gradient)
        } else {
            self
        }
    }

    @ViewBuilder
    func sfSymbolPickerForegroundStyle(_ color: Color) -> some View {
        environment(\.sfSymbolPickerForegroundStyle, SymbolForegroundStyle(color: color))
    }

    @ViewBuilder
    func sfSymbolPickerForegroundStyle(_ primary: Color, secondary: Color) -> some View {
        environment(
            \.sfSymbolPickerForegroundStyle,
             SymbolForegroundStyle(primaryColor: primary, secondaryColor: secondary)
        )
    }

    @ViewBuilder
    func sfSymbolPickerForegroundStyle(_ primary: Color, secondary: Color, tertiary: Color) -> some View {
        environment(
            \.sfSymbolPickerForegroundStyle,
             SymbolForegroundStyle(primaryColor: primary, secondaryColor: secondary, tertiaryColor: tertiary)
        )
    }

    @ViewBuilder
    func sfSymbolPickerPreviewUsesRenderingMode(_ isEnabled: Bool) -> some View {
        environment(\.sfSymbolPickerPreviewUsesRenderingMode, isEnabled)
    }
}

extension View {
    @ViewBuilder
    func foregroundStyle(_ foregroundStyle: SymbolForegroundStyle) -> some View {
        if let secondaryColor = foregroundStyle.secondaryColor, let tertiaryColor = foregroundStyle.tertiaryColor {
            self.foregroundStyle(
                foregroundStyle.primaryColor,
                secondaryColor,
                tertiaryColor
            )
        } else if let secondaryColor = foregroundStyle.secondaryColor {
            self.foregroundStyle(foregroundStyle.primaryColor, secondaryColor)
        } else {
            self.foregroundStyle(foregroundStyle.primaryColor)
        }
    }
}
