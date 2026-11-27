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
                // Hex #2C7EB4 extraído do seu Figma
                return Color(red: 44 / 255, green: 126 / 255, blue: 180 / 255)
            case .red:
                // Vermelho calibrado com o mesmo peso visual e contraste do azul
                return Color(red: 196 / 255, green: 56 / 255, blue: 56 / 255)
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
                .foregroundStyle(.white)
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
