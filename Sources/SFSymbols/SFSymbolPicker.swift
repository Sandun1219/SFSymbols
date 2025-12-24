import SwiftUI

public struct SFSymbolPicker: View {
    private let titleResource: LocalizedStringResource
    @Binding private var selection: String?
    @State private var isPresented = false

    public init(
        _ titleResource: LocalizedStringResource,
        selection: Binding<String?>
    ) {
        self.titleResource = titleResource
        self._selection = selection
    }

    public init(
        _ titleResource: LocalizedStringResource,
        selection: Binding<String>
    ) {
        self.titleResource = titleResource
        self._selection = Binding {
            selection.wrappedValue
        } set: { newValue in
            selection.wrappedValue = newValue ?? selection.wrappedValue
        }
    }

    public var body: some View {
        LabeledContent {
            Button {
                isPresented = true
            } label: {
                Group {
                    if let selection {
                        Image(systemName: selection)
                            .font(.system(size: 18))
                            .foregroundStyle(.tint)
                    } else {
                        Text("Select...")
                    }
                }
                .foregroundStyle(Color.accentColor)
                .frame(width: 30, height: 30)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        } label: {
            Text(titleResource)
        }
        .sfSymbolPicker(
            isPresented: $isPresented,
            selection: $selection
        )
    }
}

#Preview {
    @Previewable @State var selection = "tortoise"

    Form {
        SFSymbolPicker("Symbol", selection: $selection)
    }
}
