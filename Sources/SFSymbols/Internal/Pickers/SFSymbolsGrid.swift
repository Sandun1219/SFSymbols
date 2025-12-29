import SwiftUI

struct SFSymbolsGrid: View {
    let symbols: [SFSymbol]
    @Binding var selection: String?

    @State private var columns: [GridItem] = []
    @State private var tileHeight: CGFloat = 45
    @State private var symbolTileScale: CGFloat = 1
    private var edgePadding: CGFloat {
        #if os(iOS)
        27
        #else
        14
        #endif
    }
    private var preferredTileSize: CGSize {
        #if os(iOS)
        CGSize(width: 57, height: 45)
        #else
        CGSize(width: 51, height: 41)
        #endif
    }
    private var spacing: CGFloat {
        #if os(iOS)
        14
        #else
        10
        #endif
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(symbols) { symbol in
                Button {
                    selection = symbol.name
                } label: {
                    SFSymbolTile(
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

private extension SFSymbolsGrid {
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
