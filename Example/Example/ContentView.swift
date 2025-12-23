import SFSymbols
import SwiftUI

struct ContentView: View {
    @State private var selectedSFSymbol = "tortoise"

    var body: some View {
        NavigationStack {
            Form {
                SFSymbolPicker("Symbol", selection: $selectedSFSymbol)
            }
            .navigationTitle("Example")
        }
    }
}

#Preview {
    ContentView()
}
