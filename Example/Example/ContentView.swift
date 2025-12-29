import SFSymbols
import SwiftUI

struct ContentView: View {
    @State private var selectedSFSymbol = "sun.rain.fill"
    @State private var renderingMode: SymbolRenderingModeSetting = .monochrome
    @State private var primaryColor: Color = .primary
    @State private var secondaryColor: Color = .blue
    @State private var tertiaryColor: Color = .gray
    @State private var isGradientEnabled = false
    @State private var stylePreview = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    SFSymbolPicker("Symbol", selection: $selectedSFSymbol)
                        #if os(visionOS)
                        .tint(.primary)
                        #endif
                        .sfSymbolPickerRenderingMode(SymbolRenderingMode(renderingMode))
                        .backportedSFSymbolPickerColorRenderingMode(isGradientEnabled ? .gradient : .flat)
                        .sfSymbolPickerForegroundStyle(primaryColor, secondary: secondaryColor, tertiary: tertiaryColor)
                        .sfSymbolPickerPreviewUsesRenderingMode(stylePreview)
                }
                #if os(macOS)
                Divider()
                    .frame(maxWidth: 200)
                    .padding(.vertical)
                #endif
                Section {
                    Picker(selection: $renderingMode) {
                        ForEach(SymbolRenderingModeSetting.allCases) { kind in
                            Text(kind.title)
                        }
                    } label: {
                        Text("Rendering Mode")
                    }
                    LabeledContent {
                        if renderingMode == .palette {
                            HStack {
                                ColorPicker("Primary Color", selection: $primaryColor)
                                    .labelsHidden()
                                ColorPicker("Secondary Color", selection: $secondaryColor)
                                    .labelsHidden()
                                ColorPicker("Tertiary Color", selection: $tertiaryColor)
                                    .labelsHidden()
                            }
                        } else {
                            ColorPicker("Color", selection: $primaryColor)
                                .labelsHidden()
                        }
                    } label: {
                        if renderingMode == .palette {
                            Text("Colors")
                        } else {
                            Text("Color")
                        }
                    }
                    if #available(iOS 26, macOS 26, *) {
                        Toggle(isOn: $isGradientEnabled) {
                            Text("Gradient")
                        }
                    }
                }
                #if os(macOS)
                Divider()
                    .frame(maxWidth: 200)
                    .padding(.vertical)
                #endif
                Section {
                    Toggle("Style Preview", isOn: $stylePreview)
                }
            }
            .navigationTitle("Example")
        }
    }
}

#Preview {
    ContentView()
}
