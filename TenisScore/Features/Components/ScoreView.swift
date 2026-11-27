//
//  ScoreView.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 26/11/26.
//

import SwiftUI

struct ScoreView: View {

    @State var match: Match

    var body: some View {
        VStack(alignment: .center) {
            Text("Placar")
                .font(.title)
                .bold()
                .foregroundStyle(
                    .text
                )
            HStack(spacing: 16) {
                VStack {
                    Text(match.sides[0].name)
                        .foregroundStyle(Color("Team1"))
                        .font(.title2)
                        .bold()

                    Text(
                        match.sides[0].players.map(\.name).joined(
                            separator: " · "
                        )
                    )
//                    .padding(1)
                }
                .frame(maxWidth: .infinity)

                VStack {
                    Text(match.sides[1].name)
                        .foregroundStyle(Color("Team2"))
                        .font(.title2)
                        .bold()

                    Text(
                        match.sides[1].players.map(\.name).joined(
                            separator: " · "
                        )
                    )
//                    .padding(1)
                }
                .frame(maxWidth: .infinity)
            }
            Divider()

            HStack(spacing: 16) {
                Text(match.setsWon(by: match.sides[0]), format: .number)
                    .foregroundStyle(Color("Team1"))
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
                Text(match.setsWon(by: match.sides[1]), format: .number)
                    .foregroundStyle(Color("Team2"))
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
            }
            .overlay(alignment: .topLeading) {
                Text("Sets")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            Divider()

            HStack(spacing: 16) {
                Text(match.sets.last?.gamesWon(by: match.sides[0]) ?? 0, format: .number)
                    .foregroundStyle(Color("Team1"))
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                Text(match.sets.last?.gamesWon(by: match.sides[1]) ?? 0, format: .number)
                    .foregroundStyle(Color("Team2"))
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.vertical, 20)
            }
            .overlay(alignment: .topLeading) {
                Text("Games")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .glassEffect(.regular, in: .rect(cornerRadius: 26.0))
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
        ScoreView(match: match)
            .padding()
    } else {
        Text("Unable to create the preview match.")
    }
}
