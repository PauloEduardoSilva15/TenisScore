//
//  TextCapsules.swift
//  TenisScore
//
//  Created by Igor Carrasco on 27/11/26.
//

import SwiftUI

struct ServeTextCapsule: View {
    let player: String
    var teamColor: Color
    
    init(_ text: String, teamColor: Color) {
        self.player = text
        self.teamColor = teamColor
    }
    
    var body: some View {
        HStack {
            Circle()
                .frame(maxWidth: 10)
                .foregroundStyle(teamColor)
                .padding(.leading)
            Text("Saque: \(player)")
                .font(.title3)
            Image(systemName: "figure.tennis")
                .padding(.trailing)
        }
        .frame(minWidth: 205, minHeight: 39)
        .background{
            Capsule()
                .foregroundStyle(.white)
        }
        .padding()
    }
}

struct TextCapsule: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title3)
            .frame(minWidth: 205, minHeight: 39)
            .background{
                Capsule()
                    .foregroundStyle(.white)
            }
    }
}
