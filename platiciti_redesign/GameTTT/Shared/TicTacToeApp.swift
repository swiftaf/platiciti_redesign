import SwiftUI


struct TicTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewTTT()
            #if os(macOS)
            // Set a minimum width enough to show all the toolbar icons.
                .frame(minWidth: 500, minHeight: 500)
            #endif
        }
        .commands {
            // For customizing the toolbar on macOS.
            ToolbarCommands()
        }
    }
}
