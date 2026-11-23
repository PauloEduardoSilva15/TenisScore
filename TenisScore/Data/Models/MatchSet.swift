//
//  MatchSet.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData


@Model
class MatchSet {
    @Attribute(.unique)
    var id: UUID
    
    var games: [Game]
    
    init(id: UUID, games: [Game]) {
        self.id = id
        self.games = games
    }
}
