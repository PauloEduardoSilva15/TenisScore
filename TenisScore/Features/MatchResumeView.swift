//
//  MatchResumeView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 27/11/26.
//

import SwiftData
import SwiftUI

struct MatchResumeView: View {
    @Environment(AppRouter.self) private var router
    @Environment(\.modelContext) private var modelContext

    let match: Match

    var body: some View {
        VStack {
            VStack {
                TextCapsule("Partida de Tênis")
                    .padding(.top, 24)

                HStack(spacing: 16) {
                    ScoreTeamCard(side: match.sides[0], teamColor: .blue)
                        .aspectRatio(1, contentMode: .fit)
                        .padding()
                    
                    ScoreTeamCard(side: match.sides[1], teamColor: .red)
                        .aspectRatio(1, contentMode: .fit)
                        .padding()
                }

                TextCapsule(match.setQuantity.name)

                Divider()
                    .padding(.vertical, 10)

                Text("Primeiro Game")

                ServeTextCapsule(
                    match.curSet.curGame.whoServes.name,
                    teamColor: match.sides.first {
                        $0.players.contains { $0.id == match.curSet.curGame.whoServes.id }
                    }?.id == match.sides.first?.id ? .team1 : .team2
                )
            }
            .padding()
            .glassEffect(.regular, in: .rect(cornerRadius: 30))
            
            Spacer()
            
            ConfirmButton("Iniciar primeiro Game") {
                modelContext.insert(match)
                router.push(.onMatchView(match: match))
            }
            
        }
        .padding()
        .background {
            AppBackgroundImg(Image(.appBackgroundImg))
        }
        .navigationTitle("Informações da partida")
        .toolbarTitleDisplayMode(.inlineLarge)
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
        NavigationView {
            MatchResumeView(match: match)
        }
        .environment(AppRouter())
    } else {
        Text("Unable to create the preview match.")
    }

}
