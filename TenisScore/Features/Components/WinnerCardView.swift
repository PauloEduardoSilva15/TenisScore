//
//  WinnerView.swift
//  TenisScore
//
//  Created by Paulo Eduardo Barbosa da Silva on 26/11/26.
//

import SwiftUI

struct WinnerCardView: View {
    let match: Match

    enum GameOrSet {
        case game
        case set
        case match
    }

    let type: GameOrSet

    var typeText: String {
        switch type {
        case .match:
            return "Fim da Partida"
        case .game:
            return "Fim do \(match.curSet.curGameIndex+1)º Game"
        case .set:
            return "Fim do \(match.curSetIndex+1)º Set"
        }
    }

    private var winnerName: String {
        switch type {
        case .match:
            return match.winner?.name ?? "Ninguém"
        case .game:
            return match.curSet.games[match.curSet.curGameIndex].winner?.name ?? "Ninguém"
        case .set:
            return match.curSet.winner?.name ?? "Ninguém"
        }
    }

    var body: some View {
        LiquidGlassCard {
            VStack(spacing: 18) {
                Text(typeText)
                    .font(.subheadline)
                HStack{
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                    Text("Vitória de \(winnerName)")
                        .bold()
                        .font(.title2)
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                }
                
                if type != .match {
                    Divider()
                        .padding(.trailing)
                        .padding(.leading)
                    HStack(spacing: 1){
                        Text("Próximo a sacar: \(match.curSet.curGame.whoServes.name)")
                            .font(.headline)
                            .bold()
                        Image(systemName: "figure.tennis")
                    }
                    if match.curSet.games.count != 1 && match.curSet.games.count % 2 == 1 {
                        Text("Troquem o lado da quadra")
                    }
                }
                
            }.padding()
            .frame(height: 200)
            
           
        }
    }
}

private func makePreviewMatch() -> Match {
    let players = [
        Player(name: "Player 1"),
        Player(name: "Player 2")
    ]
    let match = try! Match(
        players: players,
        playerQuantity: .singles,
        setQuantity: .three,
        randomizePlayers: false
    )
    
    // Finishes the initial game. Match then starts a second game in the same set.
    
    for _ in 0...8{
        try! match.incrementPoints(for: match.sides[0])
    }
    
    return match
}

#Preview {
    ZStack{
        AppBackgroundImg(Image("AppBackgroundImg"))
        WinnerCardView(match: makePreviewMatch(), type: .game)
    }
    
}
