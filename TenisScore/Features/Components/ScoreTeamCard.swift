//
//  ScoreTeamCard.swift
//  TenisScore
//
//  Created by Vinicius de Brito on 26/11/26.
//
import SwiftUI

public struct ScoreTeamCard: View {
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

    private let title: String
    private let teamColor: TeamColor

    public init(title: String, teamColor: TeamColor) {
        self.title = title
        self.teamColor = teamColor
    }

    public var body: some View {
        let shape = RoundedRectangle(cornerRadius: 30, style: .continuous)

        VStack {
            Text(title)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.titleBtnText)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            Spacer(minLength: 0)
        }
        .padding(.top, 28)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .frame(width: 156, height: 139)
        .background(teamColor.backgroundColor, in: shape)
        // Aplica o acabamento sutil de Liquid Glass mantendo a cor sólida vibrante
        .glassEffect(.regular.tint(teamColor.backgroundColor), in: shape)
    }
}

#Preview {
    ZStack {
        Color(white: 0.1)
            .ignoresSafeArea()

        HStack(spacing: 16) {
            ScoreTeamCard(title: "Time 1", teamColor: .blue)
            ScoreTeamCard(title: "Time 2", teamColor: .red)
        }
    }
}
