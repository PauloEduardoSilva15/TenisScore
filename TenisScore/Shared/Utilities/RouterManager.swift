//
//  RouterManager.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI
import SwiftData

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

//#Preview {
//    RouterManager()
//}
