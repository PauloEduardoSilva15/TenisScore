//
//  RouterManager.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI
import SwiftData

/// View responsável por gerenciar as rotas.
///
/// Ela recebe uma rota e armazena na variável `route`.
///
/// É utilizado um `switch case` para cada opção de rota possível declarada no enum de rotas `Route`.
/// A partir daí, cada tela é chamada de acordo com a rota recebida pela view.
/// O RouterManager é uma View e existe para ser chamado na `.navigationDestination`, recebendo uma rota dentre as rotas do enum `Route`.
///
/// - Parameters:
///     - route: É uma das rotas do enum `Route`, ou seja, é o parâmetro que decide qual view será chamada no `switch case`.
struct RouterManager: View {
    let route: Route
    
//    Pra mexer com banco de dados se alguma tela precisar
//    @Environment(\.modelContext) private var context
    
    var body: some View {
        switch route {
        case .homeScreen:
            Home()
            
        case .matchCreationView:
            MatchCreationView()
            
        case .onMatchView:
            OnMatchView()
            
        case .endMatchView:
            EndMatchView()
        }
    }
}
