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
    var isEnd: Bool{
        if sets.count == setQuantity.rawValue{
            if !tieBreaker{
                status = .completed
                return true
            }
            //sets.last?.games.append(Game(UUID(), ))
        }
        
        return false
    }

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

    init(
        players: [Player],
        playerQuantity: MatchPlayerQuantity,
        setQuantity: MatchSetQuantity,
        tieBreaker: Bool = true,
        randomizePlayers: Bool = true,
        teamNames: [String] = ["Team 1", "Team 2"]
    ) throws {
        self.status = .inProgress
        self.tieBreaker = tieBreaker
        self.date = Date()
        self.playerQuantity = playerQuantity
        self.setQuantity = setQuantity

        let sides = try MatchSide.makeSides(
            teamNames: teamNames,
            players: players,
            playerQuantity: playerQuantity
        )

        self.sides = sides
        self.sets = [MatchSet(matchSides: sides, whoServes: sides.randomElement()!.players.randomElement()!)]
    }

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
