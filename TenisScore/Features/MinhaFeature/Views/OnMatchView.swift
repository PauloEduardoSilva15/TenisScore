//
//  OnMatchView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI

struct OnMatchView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        Text("Placar da partida")
        
        Button("ENCERRAR partida") {
            router.push(.endMatchView)
        }
    }
}

#Preview {
    OnMatchView()
}
