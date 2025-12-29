import SwiftUI

struct SFSymbolStyleViewModifier: ViewModifier {
    @Environment(\.symbolPickerRenderingMode) private var symbolPickerRenderingMode
    @Environment(\.symbolColorRenderingModeSetting) private var symbolColorRenderingModeSetting
    @Environment(\.symbolColorsSetting) private var symbolColorsSetting

    func body(content: Content) -> some View {
        content
            .symbolRenderingMode(symbolPickerRenderingMode)
            .symbolColorRenderingModeSetting(symbolColorRenderingModeSetting)
            .symbolColors(symbolColorsSetting)
    }
}

private extension View {
    @ViewBuilder
    func symbolColorRenderingModeSetting(_ setting: SymbolColorRenderingModeSetting) -> some View {
        if #available(iOS 26, macOS 26, *) {
            switch setting {
            case .flat:
                symbolColorRenderingMode(.flat)
            case .gradient:
                symbolColorRenderingMode(.gradient)
            }
        } else {
            self
        }
    }
}
