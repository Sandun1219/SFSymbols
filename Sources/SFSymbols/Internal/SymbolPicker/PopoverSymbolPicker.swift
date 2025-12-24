import SwiftUI

struct PopoverSymbolPicker: View {
    @Binding var selection: String?

    var body: some View {
        LoadingSymbolPicker(selection: $selection)
            .frame(width: 360, height: 500)
    }
}

#Preview {
    @Previewable @State var selection: String?

    PopoverSymbolPicker(selection: $selection)
}
