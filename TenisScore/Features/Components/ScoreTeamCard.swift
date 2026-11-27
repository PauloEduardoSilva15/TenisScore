//
//  ScoreTeamCard.swift
//  TenisScore
//
//  Created by Vinicius de Brito on 26/11/26.
//
import SwiftUI

struct ScoreTeamCard: View {
    public enum TeamColor {
        case blue
        case red

        var backgroundColor: Color {
            switch self {
            case .blue:
                return .team1
            case .red:
                return .team2
            }
        }
    }

    private let side: MatchSide
    private let teamColor: TeamColor

    init(side: MatchSide, teamColor: TeamColor) {
        self.side = side
        self.teamColor = teamColor
    }

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(teamColor.backgroundColor)
                .glassEffect(
                    .regular.tint(teamColor.backgroundColor),
                    in: .rect(cornerRadius: 30)
                )
            VStack {
                Text(side.name)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                //                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text(side.players.map(\.name).joined(separator: " · "))
                    .foregroundStyle(.white)
                //                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding()
        }
    }
}

#Preview {

    if let sides = try? MatchSide.makeSides(
        teamNames: ["Team 1", "Team 2"],
        players: ["Teste1", "Teste2"].map { Player(name: $0) },
        playerQuantity: .singles,
        randomizePlayers: true
    ) {

        ZStack {
            Color(white: 0.1)
                .ignoresSafeArea()

            HStack(spacing: 16) {
                ScoreTeamCard(side: sides[0], teamColor: .blue)
                ScoreTeamCard(side: sides[1], teamColor: .red)
            }
        }
    } else {
        Text("Error")
    }
}
