//
//  OnMatchView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI

struct OnMatchView: View {
    @Environment(AppRouter.self) private var router
    
    let match: Match
    
    var body: some View {
        Text("Placar da partida")
        
        Button("ENCERRAR partida") {
            router.push(.endMatchView)
        }
    }
}

#Preview {
    if let match = try? Match(
        players: [
            Player(name: "Paulo"), Player(name: "João"), Player(name: "Vini"),
            Player(name: "Igor"),
        ],
        playerQuantity: .pairs,
        setQuantity: .three
    ) {
        OnMatchView(match: match)
            .padding()
    } else {
        Text("Unable to create the preview match.")
    }
}
