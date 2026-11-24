//
//  Match.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

/// Model that stores everything about the whole match
@Model
class Match {

    /// The unique identificator for this match
    @Attribute(.unique)
    var id: UUID = UUID()

    /// Current status of this match, such as `inProgress` or `completed`
    var status: MatchStatus

    /// If the current match uses the tie breaker system
    var tieBreaker: Bool

    /// When the current game has been started
    var date: Date

    /// Quantity of players per side
    var playerQuantity: MatchPlayerQuantity

    /// Quantity of sets in this match, options are `.three` or `.five`
    var setQuantity: MatchSetQuantity

    /// Both sides of the match
    var sides: [MatchSide]

    /// All sets of the current match
    var sets: [MatchSet]

    init(
        status: MatchStatus,
        tieBreaker: Bool,
        date: Date,
        playerQuantity: MatchPlayerQuantity,
        setQuantity: MatchSetQuantity,
        sides: [MatchSide],
        sets: [MatchSet]
    ) {
        self.status = status
        self.tieBreaker = tieBreaker
        self.date = date
        self.playerQuantity = playerQuantity
        self.setQuantity = setQuantity
        self.sides = sides
        self.sets = sets
    }
/*
    init(
        players: [Player],
        playerQuantity: MatchPlayerQuantity,
        setQuantity: MatchSetQuantity,
        tieBreaker: Bool = true,
        randomizePlayers: Bool = true
    ) {
        self.status = .inProgress
        self.tieBreaker = tieBreaker
        self.date = Date()
        self.playerQuantity = playerQuantity
        self.setQuantity = setQuantity
        
        // needs a function on MatchSide to create both match sides given a list of players and if it should be randomized

        self.sets = sets
    }
 */

}

/// The status of the match
enum MatchStatus: String, Codable {
    /// When the match is in progress
    case inProgress

    /// When the match has been completed
    case completed
}

enum MatchPlayerQuantity: Int, Codable {
    /// Single player per side
    case singles = 1

    /// Two players per side
    case pairs = 2
    
    var name: String {
        switch self {
        case .singles:
            return "Singles"
        case .pairs:
            return "Pairs"
        }
    }
}

enum MatchSetQuantity: Int, Codable {
    /// Best of three sets
    case three = 3

    /// Best of five sets
    case five = 5

    /// Whole english name for the quantity of sets
    var name: String {
        switch self {
        case .three:
            return "Three"

        case .five:
            return "Five"
        }
    }
}
