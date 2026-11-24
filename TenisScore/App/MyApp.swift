import SwiftUI

@main struct MyApp: App {
    /// Instancia o `AppRouter()` como `@State` armazenado na variável `router`, para atualizar a interface automaticamente sempre que o router for alterado.
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
