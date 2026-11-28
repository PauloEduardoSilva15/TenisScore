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
        VStack {
            ScoreView(match: match)

            Spacer()

            VStack {
                Text("Pontuação")
                    .font(.title)
                    .fontWeight(.semibold)

                HStack(spacing: 16) {
                    MatchScoreView(
                        side: match.sides[0],
                        match: match,
                        teamColor: .team1
                    )

                    MatchScoreView(
                        side: match.sides[1],
                        match: match,
                        teamColor: .team2
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                ServeTextCapsule(
                    match.curSet.curGame.whoServes.name,
                    teamColor: match.sides.first {
                        $0.players.contains {
                            $0.id == match.curSet.curGame.whoServes.id
                        }
                    }?.id == match.sides.first?.id ? .team1 : .team2
                )
            }
            .padding()
            .glassEffect(.regular, in: .rect(cornerRadius: 30))
        }
        .padding()
        .background {
            AppBackgroundImg(Image("AppBackgroundImg"))
        }
        .navigationTitle("Partida em Andamento")
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
        NavigationStack {
            OnMatchView(match: match)
        }
        .environment(AppRouter())
    } else {
        Text("Unable to create the preview match.")
    }
}
