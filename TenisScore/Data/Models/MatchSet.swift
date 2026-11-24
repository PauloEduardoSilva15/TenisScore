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
    var games: [Game]
    
    init(games: [Game]) {
        self.games = games
    }
}
