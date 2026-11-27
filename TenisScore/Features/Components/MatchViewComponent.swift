//
//  MatchViewComponent.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 26/11/26.
//

import SwiftUI

struct MatchViewComponent: View {

    var match: Match

    var body: some View {
        if let side = match.winner ?? match.sides.first {
            let teamColor = Color(side.id == match.sides.first?.id ? "Team1" : "Team2")

            HStack(alignment: .center, spacing: 16) {
                VStack(spacing: 0) {
                    VStack(spacing: 8) {
                        Text(side.name)
                            .font(.title2.bold())

                        Text(side.players.map(\.name).joined(separator: " · "))
                            .font(.callout)
                    }
                    .multilineTextAlignment(.center)
                    .padding(16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    Text(match.winner == nil ? "Em andamento" : "Vencedores")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(.black.opacity(0.15))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(teamColor)
                .clipShape(.rect(cornerRadius: 28))

                VStack(spacing: 12) {
                    Text("Placar \(match.sides.map { String(match.setsWon(by: $0)) }.joined(separator: " a "))")
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(Color.cardBg, in: .rect(cornerRadius: 20))

                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(match.playerQuantity.rawValue) vs \(match.playerQuantity.rawValue) · \(match.setQuantity.rawValue) sets")
                        Text(match.date, format: .dateTime.day().month(.abbreviated))
                        Text("Tênis")
                    }
                    .font(.callout)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(Color.cardBg, in: .rect(cornerRadius: 20))
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.titleText)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(12)
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 30))
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
        MatchViewComponent(match: match)
            .padding()
    } else {
        Text("Unable to create the preview match.")
    }
}
