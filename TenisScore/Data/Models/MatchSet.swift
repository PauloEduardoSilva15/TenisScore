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
    
    /// List of games in this set
    var games: [Game] = []
    
    init(matchSides: [MatchSide], whoServes: MatchSide?) {
        self.games = [
            Game(matchSides: matchSides, whoServes: whoServes)
        ]
    }
}
