//
//  MatchSide.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData


@Model
class MatchSide {
    @Attribute(.unique)
    var id: UUID
    var name: String
    
    var players: [Player]
    
    init(id: UUID, name: String, players: [Player]) {
        self.id = id
        self.name = name
        self.players = players
    }
}
