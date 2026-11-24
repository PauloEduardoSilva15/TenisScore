//
//  Router.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import Foundation

/// Enum de Rotas.
///
/// Este enum determina o tipo `Route` e deve ter um `case` para cada view ou sheet que será utilizada pelo app
enum Route: Hashable {
    case homeScreen
    case matchCreationView
    case onMatchView
    case endMatchView
}

/// Esta extensão tem como objetivo transformar o enum `Route` em `Identifiable`, utilizando cada case como seu próprio `id`.
extension Route: Identifiable {
    var id: Self { self }
}
