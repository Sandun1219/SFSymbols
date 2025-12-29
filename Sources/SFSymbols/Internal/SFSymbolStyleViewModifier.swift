import SwiftUI

struct SFSymbolStyleViewModifier: ViewModifier {
    @Environment(\.sfSymbolPickerRenderingMode) private var renderingMode
    @Environment(\.sfSymbolPickerColorRenderingMode) private var colorRenderingMode
    @Environment(\.sfSymbolPickerForegroundStyle) private var foregroundStyle

    func body(content: Content) -> some View {
        content
            .symbolRenderingMode(renderingMode)
            .backportedSymbolColorRenderingMode(colorRenderingMode)
            .foregroundStyle(foregroundStyle)
    }
}

private extension View {
    @ViewBuilder
    func backportedSymbolColorRenderingMode(_ mode: BackportedSymbolColorRenderingMode) -> some View {
        if #available(iOS 26, *) {
            switch mode {
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
