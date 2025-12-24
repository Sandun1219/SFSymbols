import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(
                    minWidth: 400,
                    idealWidth: 500,
                    maxWidth: 600,
                    minHeight: 300,
                    idealHeight: 375,
                    maxHeight: 450
                )
            #endif
        }
        #if os(macOS)
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        #endif
    }
}
