//
//  Router.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import Foundation

enum Route: Hashable {
    case homeScreen
    case matchCreationView
    case onMatchView
    case endMatchView
}

extension Route: Identifiable {
    var id: Self { self }
}
