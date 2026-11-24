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
    var isEnd: Bool {
        return games.count == 6 && games.last?.isEnd == true
    }
    
    init(id: UUID, games: [Game]) {
        self.id = id
        self.games = games
    }
    
}
