import SwiftUI

@main struct MyApp: App {
    @State private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                Group {
                    Home()
                }
                .navigationDestination(for: Route.self) { route in
                    RouterManager(route: route)
                }
            }
            .environment(router)
        }
    }
}
