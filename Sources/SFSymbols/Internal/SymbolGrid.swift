import SwiftUI

struct SymbolGrid: View {
    let symbols: [SFSymbol]
    @Binding var selection: String?

    @State private var columns: [GridItem] = []
    @State private var tileHeight: CGFloat = 45
    @State private var symbolTileScale: CGFloat = 1

    private let edgePadding: CGFloat = 27
    private let preferredTileSize = CGSize(width: 57, height: 45)
    private let spacing: CGFloat = 14

    var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(symbols) { symbol in
                Button {
                    selection = symbol.name
                } label: {
                    SymbolTile(
                        scale: symbolTileScale,
                        systemName: symbol.name,
                        isSelected: symbol.name == selection
                    )
                    .tint(.primary)
                    .frame(height: tileHeight)
                }
                .buttonStyle(.plain)
            }
        }
        .onGeometryChange(for: CGFloat.self) { proxy in
            proxy.size.width
        } action: { newValue in
            let itemWidth = itemWidth(forContainerWidth: newValue)
            columns = [GridItem(.adaptive(minimum: itemWidth, maximum: itemWidth), spacing: spacing)]
            tileHeight = round(itemWidth * preferredTileSize.height / preferredTileSize.width)
            symbolTileScale = itemWidth / preferredTileSize.width
        }
    }
}

private extension SymbolGrid {
    private func itemWidth(forContainerWidth containerWidth: CGFloat) -> CGFloat {
        guard containerWidth > 0 else {
            return preferredTileSize.width
        }
        let availableWidth = containerWidth - edgePadding * 2
        let rawCount = (availableWidth + spacing) / (preferredTileSize.width + spacing)
        let itemCount = max(1, Int(floor(rawCount)))
        let totalSpacing = CGFloat(itemCount - 1) * spacing
        return floor((availableWidth - totalSpacing) / CGFloat(itemCount))
    }
}

private extension SymbolGrid {
    private struct SymbolTile: View {
        let scale: CGFloat
        let systemName: String
        let isSelected: Bool

        @Environment(\.displayScale) private var displayScale

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: round(12 * scale), style: .continuous)
                    .foregroundStyle(.background.secondary)
                Image(systemName: systemName)
                    .font(.system(size: 18 * scale, weight: .regular))
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(.primary)
                if isSelected {
                    RoundedRectangle(cornerRadius: round(12 * scale), style: .continuous)
                        .stroke(Color.accentColor, lineWidth: 2)
                } else {
                    RoundedRectangle(cornerRadius: round(12 * scale), style: .continuous)
                        .stroke(.separator, lineWidth: 1 / displayScale)
                }
            }
        }
    }
}
