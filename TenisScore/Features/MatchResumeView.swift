//
//  MatchResumeView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 27/11/26.
//

import SwiftUI

struct MatchResumeView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        ScrollView {
            Text("Aqui é o resumo da sua partida")
            
            ConfirmButton("Começar partida") {
                router.push(.onMatchView)
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .background {
            AppBackgroundImg(Image(.appBackgroundImg))
        }
        .navigationTitle("Resumo da partida")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
}

#Preview {
    NavigationView {
        MatchResumeView()
    }
    .environment(AppRouter())
}
