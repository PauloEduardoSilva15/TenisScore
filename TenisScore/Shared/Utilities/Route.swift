//
//  Router.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import Foundation

/// Application navigation routes.
///
/// Defines the `Route` type used by the navigation system.
/// Each screen or sheet that can be presented by the app
/// should have a corresponding case in this enum.
enum Route: Hashable {
    case homeScreen
    case newMatchView
    case onMatchView(match: Match)
    case endMatchView
}

/// Makes `Route` conform to `Identifiable`,
/// allowing route values to be used in SwiftUI APIs that
/// require uniquely identifiable items.
///
/// Each route uses itself as its identifier.
///
/// Makes `Route` conform to `Identifiable` so it can be
/// used with SwiftUI sheet presentation APIs such as
/// `.sheet(item:)`.
extension Route: Identifiable {
    var id: Self { self }
}
