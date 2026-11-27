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
            LiquidGlassCard {
                VStack {
                    TextCapsule("Partida de Tênis")
                        .padding()
                    
                    HStack(spacing: 16) {
                        ScoreTeamCard(title: "Time 1", teamColor: .blue)
                        ScoreTeamCard(title: "Time 2", teamColor: .red)
                    }
                    .padding()
                    
                    TextCapsule("5 Sets")
                        .padding()
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text("Primeiro Game")
                    
                    ServeTextCapsule("Player", teamColor: .team1)
                }
                .padding(.bottom)
            }
            .padding()
            
            ConfirmButton("Iniciar primeiro Game") {
                router.push(.onMatchView)
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .background {
            AppBackgroundImg(Image(.appBackgroundImg))
        }
        .navigationTitle("Informações da partida")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
}

#Preview {
    NavigationView {
        MatchResumeView()
    }
    .environment(AppRouter())
}
