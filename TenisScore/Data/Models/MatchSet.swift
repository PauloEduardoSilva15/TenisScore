//
//  MatchSet.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

/// Model representing one set in a match
@Model
class MatchSet {
    
    /// Unique identifier for this set
    @Attribute(.unique)
    var id: UUID = UUID()
    var isEnd: Bool {
        return games.count == 6 && games.last?.isEnd == true
    }
    /// List of games in this set
    var games: [Game] = []
    
    init(matchSides: [MatchSide], whoServes: Player?) {
        self.games = [
            Game(matchSides: matchSides, whoServes: whoServes)
        ]
    }
    
}
