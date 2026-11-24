//
//  RouterManager.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI
import SwiftData

/// View responsável por gerenciar as rotas. Ela recebe uma rota e armazena na variável `route`. É utilizado um `switch case` para cada opção de rota possível declarada no enum de rotas `Route`. A partir daí, cada tela é chamada de acordo com a rota recebida pela view.
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
