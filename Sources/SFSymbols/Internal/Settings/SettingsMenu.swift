import SwiftUI

struct SettingsMenu: View {
    @Binding var symbolBackgroundSetting: SymbolBackgroundSetting

    var body: some View {
        Menu {
            Picker(selection: $symbolBackgroundSetting) {
                ForEach(SymbolBackgroundSetting.allCases) { setting in
                    Text(setting.title)
                }
            } label: {
                Text("Background")
            }
            .pickerStyle(.inline)
        } label: {
            Label("Settings", systemImage: "ellipsis")
                .labelStyle(.iconOnly)
        }
    }
}
