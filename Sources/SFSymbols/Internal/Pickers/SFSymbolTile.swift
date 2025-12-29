import SwiftUI

struct SFSymbolTile: View {
    let scale: CGFloat
    let systemName: String
    let isSelected: Bool

    @Environment(\.displayScale) private var displayScale
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.symbolBackgroundSetting) private var symbolBackgroundSetting
    private var cornerRadius: CGFloat {
        round(12 * scale)
    }
    private var strokeStyle: some ShapeStyle {
        isSelected ? AnyShapeStyle(Color.blue) : AnyShapeStyle(.separator)
    }
    private var preferredColorScheme: ColorScheme {
        switch symbolBackgroundSetting {
        case .default:
            colorScheme
        case .light:
            .light
        case .dark:
            .dark
        }
    }

    var body: some View {
        BackgroundView(cornerRadius: cornerRadius)
            .overlay {
                Image(systemName: systemName)
                    .font(.system(size: 18 * scale, weight: .regular))
                    .modifier(SFSymbolStyleViewModifier())
            }
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(strokeStyle, lineWidth: isSelected ? 2 : 1 / displayScale)
            }
            .colorScheme(preferredColorScheme)
    }
}

private extension SFSymbolTile {
    struct BackgroundView: View {
        let cornerRadius: CGFloat

        @Environment(\.colorScheme) private var colorScheme
        private var backgroundStyle: some ShapeStyle {
            switch colorScheme {
            case .light:
                AnyShapeStyle(.background)
            case .dark:
                AnyShapeStyle(.background.secondary)
            @unknown default:
                AnyShapeStyle(.background.secondary)
            }
        }

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(backgroundStyle)
                    #if os(macOS)
                    .opacity(0.6)
                    #endif
                #if os(macOS)
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                #endif
            }
        }
    }
}
