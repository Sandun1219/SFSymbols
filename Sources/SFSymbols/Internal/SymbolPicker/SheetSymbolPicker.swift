import SwiftUI

struct SheetSymbolPicker: View {
    @Binding var selection: String?

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            LoadingSymbolPicker(selection: $selection)
                .background(BackgroundView())
                .navigationTitle("Symbols")
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if #available(iOS 26, *) {
                            Button(role: .close) {
                                dismiss()
                            }
                        } else {
                            Button {
                                dismiss()
                            } label: {
                                Label("Close", systemImage: "xmark")
                                    .labelStyle(.iconOnly)
                            }
                        }
                    }
                }
            #endif
        }
    }
}

private extension SheetSymbolPicker {
    struct BackgroundView: View {
        @Environment(\.colorScheme) private var colorScheme
        private var backgroundStyle: some ShapeStyle {
            switch colorScheme {
            case .light:
                AnyShapeStyle(.background.secondary)
            case .dark:
                AnyShapeStyle(.background)
            @unknown default:
                AnyShapeStyle(.background.secondary)
            }
        }

        var body: some View {
            Rectangle()
                .fill(backgroundStyle)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    @Previewable @State var selection: String?

    SheetSymbolPicker(selection: $selection)
}
