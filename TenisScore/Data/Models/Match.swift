//
//  Match.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

@Model
class Match {
    @Attribute(.unique)
    var id: UUID
    
    var status: MatchStatus
    var tieBreaker: Bool
    var date: Date
    var playerQuantity: MatchPlayerQuantity
    var setQuantity: MatchSetQuantity
    var sides: [MatchSide]
    var sets: [MatchSet]
    
    init(id: UUID, status: MatchStatus, tieBreaker: Bool, date: Date, playerQuantity: MatchPlayerQuantity, setQuantity: MatchSetQuantity, sides: [MatchSide], sets: [MatchSet]) {
        self.id = id
        self.status = status
        self.tieBreaker = tieBreaker
        self.date = date
        self.playerQuantity = playerQuantity
        self.setQuantity = setQuantity
        self.sides = sides
        self.sets = sets
    }
    
}

enum MatchStatus: String, Codable {
    case inProgress, completed
}

enum MatchPlayerQuantity: String, Codable {
    case singles, pairs
}

enum MatchSetQuantity: Int, Codable {
    case three = 3
    case five = 5
    
    var name: String {
        switch (self) {
        case .three:
            return "Three"
        
        case .five:
            return "Five"
        }
    }
}
