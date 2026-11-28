//
//  MatchScoreView.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 27/11/26.
//

import SwiftUI

struct MatchScoreView: View {
    let side: MatchSide
    let match: Match
    let teamColor: Color
    @ScaledMetric(relativeTo: .title) private var scoreSize = 66
    
    var body: some View {
        VStack {
            VStack {
                Spacer(minLength: 0)
                Text(side.name)
                    .font(.callout)
                    .fontWeight(.semibold)
                Text(
                    match.curGamePointPerSide[side]!,
                    format: .number
                )
                .font(
                    .system(
                        size: scoreSize,
                        weight: .bold,
                        design: .default
                    )
                )
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(
                teamColor,
                in: .rect(cornerRadius: 30)
            )
            .glassEffect(
                .regular.tint(teamColor),
                in: .rect(cornerRadius: 30)
            )
            
            HStack {
                Spacer()
                Button {
                    try? match.decrementPoints(for: side)
                } label: {
                    Image(systemName: "minus")
                        .foregroundStyle(
                            teamColor
                        )
                }
                Spacer()
                
                Spacer()
                Button {
                    try? match.incrementPoints(for: side)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(
                            teamColor
                        )
                }
                Spacer()
            }
            .padding(8)
            .glassEffect(.regular, in: .capsule)
            
        }
    }
}
