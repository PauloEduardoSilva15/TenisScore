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

    /// Current set of this match
    var curSet: MatchSet {
        return sets[curSetIndex]
    }

    /// Currrent set index in `sets` array
    var curSetIndex: Int {
        self.sets.count {
            $0.isEnd
        }
    }

    /// Current amount of points of game per side
    var curGamePointPerSide: [MatchSide: Int] {
        var tmpDict: [MatchSide: Int] = [:]

        for game in curSet.games {
            for pointSide in game.points {
                tmpDict[pointSide.matchSide] = pointSide.points
            }
        }

        return tmpDict
    }

    /// Checks if this match has ended
    var isEnd: Bool {
        if sets.count == setQuantity.rawValue {
            if !tieBreaker {
                status = .completed
                return true
            }
            // TODO: Verificar tie breaker
        }

        return false
    }

    /// Show who is winning this match by number of sets
    var whoIsWinning: MatchSide {

        let first = setsWon(by: sides[0])
        let second = setsWon(by: sides[1])

        // dont care if it is equal
        return first > second ? sides[0] : sides[1]

    }

    /// If someone won this match, set it to the winning side
    var winner: MatchSide? {
        let setsNeeded = setQuantity.rawValue / 2 + 1

        return sides.first { setsWon(by: $0) >= setsNeeded }
    }

    /// Initiates a new match, ready to play
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
        self.sets = [
            MatchSet(
                matchSides: sides,
                useTieBreaker: tieBreaker,
                whoServes: sides.randomElement()!.players.randomElement()!
            )
        ]
    }

    /// Number of completed sets won by a side.
    func setsWon(by side: MatchSide) -> Int {
        sets.filter { $0.winner?.id == side.id }.count
    }

    /// Internal function to start a new set on this match
    private func startNextSet() {
        sets.append(
            MatchSet(matchSides: sides, useTieBreaker: tieBreaker)
        )
    }

    /// Internal function to start the next game on this match
    private func startNextGame(in set: MatchSet) {
        do {
            try set.startNextGame()
        } catch {
            print(error.localizedDescription)
        }
    }

    private func activeSetAndGame() throws -> (MatchSet, Game) {
        guard status == .inProgress, winner == nil,
            let set = sets.last, !set.isEnd,
            let game = set.games.last, !game.isEnd
        else { throw MatchError.matchFinished }
        return (set, game)
    }

    /// Increment points for a side, checking to start next set or game
    func incrementPoints(for side: MatchSide) throws {
        let (set, game) = try activeSetAndGame()
        game.incrementPoint(for: side)

        guard game.winner != nil else { return }

        if set.winner != nil {
            if winner != nil {
                status = .completed
            } else {
                startNextSet()
            }
        } else {
            startNextGame(in: set)
        }
    }

    /// Decrement points for a side on the current game.
    func decrementPoints(for side: MatchSide) throws {
        let (_, game) = try activeSetAndGame()
        game.decrementPoint(for: side)
    }
}

extension Match {
    /// Errors for Match
    enum MatchError: String, Error {
        case matchFinished = "Match has already finished"
    }
}

/// The status of the match
enum MatchStatus: String, Codable {
    /// When the match is in progress
    case inProgress

    /// When the match has been completed
    case completed
}

/// Quantity of players per side of match
enum MatchPlayerQuantity: Int, Codable, CaseIterable, Identifiable {
    /// Single player per side
    case singles = 1

    /// Two players per side
    case pairs = 2
    
    /// To conform to Identifiable protocol
    var id: Self { self }

    /// The whole name for this quantity of players per side
    var name: String {
        switch self {
        case .singles:
            return "Singles"
        case .pairs:
            return "Duplas"
        }
    }
}

extension MatchPlayerQuantity {
    /// Total number of players in the match (both sides).
    var totalPlayers: Int { rawValue * 2 }

    /// Returns the final player names, replacing blank ones with a default.
    /// - Parameter typed: Names typed by the user, in field order.
    /// - Returns: Exactly ``totalPlayers`` names.
    func resolvedNames(from typed: [String]) -> [String] {
        (0..<totalPlayers).map { index in
            let name = index < typed.count
                ? typed[index].trimmingCharacters(in: .whitespaces)
                : ""
            return name.isEmpty ? "Jogador \(index + 1)" : name
        }
    }
}

/// Quantity of sets per match, bo3 or bo5
enum MatchSetQuantity: Int, Codable, CaseIterable, Identifiable {
    /// Best of three sets
    case three = 3

    /// Best of five sets
    case five = 5
    
    /// To conform to Identifiable protocol
    var id: Self { self }

    /// Whole english name for the quantity of sets
    var name: String {
        switch self {
        case .three:
            return "3 Sets"

        case .five:
            return "5 Sets"
        }
    }
}

