//
//  Player.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

/// Model representing a player
@Model
class Player {
    
    /// Unique Identifier for this player
    @Attribute(.unique)
    var id: UUID = UUID()
    
    /// The name of this player
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
