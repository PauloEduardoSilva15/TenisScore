//
//  MatchCreationView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI

struct MatchCreationView: View {
    let match: Match
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        NavigationStack{
            ZStack{
                AppBackgroundImg(Image("AppBackgroundImg"))
                    .allowsHitTesting(false)
                VStack{
                    ScoreView(match: match)
                }
            }
        }
    }
}

#Preview {
    if let match = try? Match(
        players: [Player(name: "Player 1"), Player(name: "Player 2")],
        playerQuantity: .singles,
        setQuantity: .three
    ) {
        MatchCreationView(match: match)
            .environment(AppRouter())
    }
}
