//
//  MatchCreationView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI

struct MatchCreationView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        Text("Criar partida")
        
        Button("Jogar partida") {
            router.push(.onMatchView)
        }
    }
}

#Preview {
    MatchCreationView()
}
