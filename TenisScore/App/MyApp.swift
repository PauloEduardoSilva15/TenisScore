import SwiftUI
import SwiftData

@main struct MyApp: App {
    /// Stores the application's navigation router.
    ///
    /// The router is declared as `@State` so SwiftUI can react to
    /// whenever the navigation state changes.
    @State private var router = AppRouter()
    
    /// This `init()` is to set the largeTitleText and titleTextAttributes to color white
    init() {
        let white: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = white
        UINavigationBar.appearance().titleTextAttributes = white
    }
    
    var body: some Scene {
        WindowGroup {
            /// Root navigation container for the application.
            ///
            /// Navigation is driven by `AppRouter` through its `NavigationPath`.
            NavigationStack(path: $router.path) {
                Group {
                    HomeView()
                }
                .navigationDestination(for: Route.self) { route in
                    RouterManager(route: route)
                }
            }
            .environment(router)
            .modelContainer(for: [
                Match.self, MatchSet.self, Game.self,
                GameSidePoints.self, MatchSide.self, Player.self
            ])
        }
    }
}
