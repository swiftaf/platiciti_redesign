import SwiftUI
import Combine

typealias EventPublisher = PassthroughSubject<Void, Never>

struct ContentViewTTT : View {
    /// The appearance of the app.
    ///
    /// The user can choose to override the
    /// system look, forcing dark or light mode.
    @AppStorage("appearance") private var appearance = Appearance.system
    
    /// The text presented by the navigation bar on iOS
    /// and the window on macOS.
    @State private var navigationTitle = ""
    
    /// A publisher for sending reset events.
    private let resetPublisher = EventPublisher()
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let width = geometry.size.width, height = geometry.size.height
                TicTacToeGrid(navigationTitle: $navigationTitle,
                              resetPublisher: resetPublisher,
                              // Add 5% padding.
                              length: 0.7 * min(width, height))
                // Center the grid.
                .frame(width: width, height: width)
            }
            .navigationTitle(navigationTitle)
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar(id: "actions") {
                ToolbarItem(id: "restart", placement: .primaryAction) {
                    RestartButton(resetPublisher: resetPublisher)
                }
                ToolbarItem(id: "mode") {
                    SwitchGameModeButton(resetPublisher: resetPublisher)
                }
                ToolbarItem(id: "difficulty") {
                    DifficultyMenu()
                }
                //            ToolbarItem(id: "appearance") {
                //                AppearanceMenu()
                //            }
            }
            .preferredColorScheme(appearance.preferredColorScheme)
            Spacer()
            Text(navigationTitle)
                .font(.title2)
           
            HStack {
                RestartButton(resetPublisher: resetPublisher)
                SwitchGameModeButton(resetPublisher: resetPublisher)
                DifficultyMenu()
            }
            .padding(.vertical, 60)
            Spacer()
            Spacer()
        }
        #if os(iOS)
//        .wrapInNavigationStack()
        #endif
    }
}

// `NavigationViewStyle.stack` is not available on macOS
// and `NavigationStack` requires iOS 16+ and macOS 13+.
// Can we have some backwards compatibility, Apple?
#if os(iOS)
extension View {
    func wrapInNavigationStack() -> some View {
        NavigationView {
            self
        }
        .navigationViewStyle(.stack)
    }
}
#endif

struct ContentViewTTTPreviews: PreviewProvider {
    static var previews: some View {
        ContentViewTTT()
    }
}
