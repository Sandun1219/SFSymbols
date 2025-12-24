import SwiftUI

struct PopoverSFSymbolPicker: View {
    @Binding var selection: String?

    var body: some View {
        SFSymbolsLoader { symbols in
            SFSymbolsView(selection: $selection, symbols: symbols)
        }
        .frame(width: 360, height: 500)
    }
}

#Preview {
    @Previewable @State var selection: String?

    PopoverSFSymbolPicker(selection: $selection)
}
