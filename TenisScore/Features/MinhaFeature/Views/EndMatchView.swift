//
//  EndMatchView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI

struct EndMatchView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        Text("PARTIDA ENCERRADA, VOCÊ GANHOU!")
        
        Button("Voltar para o começo") {
            router.popAll()
        }
    }
}

#Preview {
    EndMatchView()
}
