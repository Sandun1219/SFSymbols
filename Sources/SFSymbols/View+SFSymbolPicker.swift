import SwiftUI

public extension View {
    func sfSymbolPicker(
        isPresented: Binding<Bool>,
        selection: Binding<String?>
    ) -> some View {
        modifier(
            SFSymbolPickerViewModifier(
                isPresented: isPresented,
                selection: selection
            )
        )
    }
}

private struct SFSymbolPickerViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selection: String?

    func body(content: Content) -> some View {
        #if os(macOS)
        content.popover(isPresented: $isPresented, arrowEdge: .top) {
            PopoverSFSymbolPicker(selection: $selection)
        }
        #else
        content.sheet(isPresented: $isPresented) {
            SheetSFSymbolPicker(selection: $selection)
        }
        #endif
    }
}
