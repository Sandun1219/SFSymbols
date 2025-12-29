import SwiftUI

enum SymbolRenderingModeSetting: String, CaseIterable, Identifiable {
    case monochrome
    case hierarchical
    case palette
    case multicolor

    var id: Self {
        self
    }

    var title: LocalizedStringResource {
        switch self {
        case .monochrome:
            "Monochrome"
        case .hierarchical:
            "Hierarchical"
        case .palette:
            "Palette"
        case .multicolor:
            "Multicolor"
        }
    }
}

extension SymbolRenderingMode {
    init(_ mode: SymbolRenderingModeSetting) {
        switch mode {
        case .monochrome:
            self = .monochrome
        case .hierarchical:
            self = .hierarchical
        case .palette:
            self = .palette
        case .multicolor:
            self = .multicolor
        }
    }
}

extension View {
    func gradientSymbolColorRenderingMode(_ gradient: Bool) -> some View {
        modifier(GradientSymbolColorRenderingMode(gradient: gradient))
    }
}

private struct GradientSymbolColorRenderingMode: ViewModifier {
    let gradient: Bool

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.symbolColorRenderingMode(gradient ? .gradient : .flat)
        } else {
            content
        }
    }
}
