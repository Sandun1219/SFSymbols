import SwiftUI

private struct SymbolPickerRenderingModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: SymbolRenderingMode = .monochrome
}

private struct SymbolColorRenderingModeSettingEnvironmentKey: EnvironmentKey {
    static let defaultValue: SymbolColorRenderingModeSetting = .flat
}

private struct SymbolColorsSettingEnvironmentKey: EnvironmentKey {
    static let defaultValue = SymbolColorsSetting()
}

private struct SymbolBackgroundSettingEnvironmentKey: EnvironmentKey {
    static let defaultValue: SymbolBackgroundSetting = .default
}

private struct SymbolPickerPreviewUsesRenderingModeEnvironmentKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var symbolPickerRenderingMode: SymbolRenderingMode {
        get { self[SymbolPickerRenderingModeEnvironmentKey.self] }
        set { self[SymbolPickerRenderingModeEnvironmentKey.self] = newValue }
    }

    var symbolColorRenderingModeSetting: SymbolColorRenderingModeSetting {
        get { self[SymbolColorRenderingModeSettingEnvironmentKey.self] }
        set { self[SymbolColorRenderingModeSettingEnvironmentKey.self] = newValue }
    }

    var symbolColorsSetting: SymbolColorsSetting {
        get { self[SymbolColorsSettingEnvironmentKey.self] }
        set { self[SymbolColorsSettingEnvironmentKey.self] = newValue }
    }

    var symbolBackgroundSetting: SymbolBackgroundSetting {
        get { self[SymbolBackgroundSettingEnvironmentKey.self] }
        set { self[SymbolBackgroundSettingEnvironmentKey.self] = newValue }
    }

    var symbolPickerPreviewUsesRenderingMode: Bool {
        get { self[SymbolPickerPreviewUsesRenderingModeEnvironmentKey.self] }
        set { self[SymbolPickerPreviewUsesRenderingModeEnvironmentKey.self] = newValue }
    }
}
