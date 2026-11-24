//
//  Router.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import Foundation

/// Enum de Rotas. Deve conter `case` para cada view e sheet que será utilizada.
enum Route: Hashable {
    case homeScreen
    case matchCreationView
    case onMatchView
    case endMatchView
}

extension Route: Identifiable {
    var id: Self { self }
}
