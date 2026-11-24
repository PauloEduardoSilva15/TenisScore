//
//  MatchSide.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

/// Model representing a side in a match
@Model
class MatchSide {
    
    /// Unique Identifier for this match side
    @Attribute(.unique)
    var id: UUID = UUID()
    
    /// List of players in this side
    var players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
}
