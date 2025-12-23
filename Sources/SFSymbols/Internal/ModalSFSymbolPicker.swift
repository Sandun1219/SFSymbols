import SwiftUI

public struct ModalSFSymbolPicker: View {
    @State private var isLoading = true
    @State private var loadError: Error?
    @State private var symbols: SFSymbols?
    @Binding private var selection: String?
    @Environment(\.dismiss) private var dismiss

    public init(selection: Binding<String?>) {
        self._selection = selection
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                if isLoading {
                    ContentUnavailableView {
                        ZStack {
                            // Add a hidden SF Symbol to ensure we can load the CoreGlyphs bundle.
                            Image(systemName: "tortoise")
                                .opacity(0)
                            ProgressView()
                                .scaleEffect(2)
                        }
                    } description: {
                        Text("Loading...")
                            .padding(.top)
                    }
                    .background(.background.secondary)
                } else if let loadError {
                    ContentUnavailableView(
                        "Could not load symbols",
                        systemImage: "exclamationmark.triangle.fill",
                        description: Text(loadError.localizedDescription)
                    )
                    .background(.background.secondary)
                } else if let symbols {
                    SymbolPicker(selection: $selection, symbols: symbols)
                        .background(.background.secondary)
                }
            }
            .navigationTitle("Symbols")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
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
        }
        .task {
            loadSymbols()
        }
    }
}

private extension ModalSFSymbolPicker {
    private func loadSymbols() {
        Task.detached(name: "Load SFSymbols", priority: .userInitiated) {
            do {
                let symbols = try await SFSymbols()
                await MainActor.run {
                    self.symbols = symbols
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.loadError = error
                    self.isLoading = false
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selection: String?

    ModalSFSymbolPicker(selection: $selection)
}
