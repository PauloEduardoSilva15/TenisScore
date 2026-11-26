//
//  RouterManager.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI
import SwiftData

/// Manages the application's navigation routes.
///
/// Receives a `Route` and returns the corresponding destination view.
///
/// A `switch` statement is used to match each route defined in the
/// `Route` enum with its associated screen.
///
/// `RouterManager` is used by `.navigationDestination` to determine
/// which view should be presented for a given navigation route.
///
/// - Parameter route: A value from the `Route` enum that determines
///   which view will be displayed.
struct RouterManager: View {
    let route: Route
    
//    Pra mexer com banco de dados se alguma tela precisar
//    @Environment(\.modelContext) private var context
    
    var body: some View {
        switch route {
        case .homeScreen:
            Home()
            
        case .newMatchView:
            NewMatchView()
            
        case .onMatchView:
            OnMatchView()
            
        case .endMatchView:
            EndMatchView()
        }
    }
}
