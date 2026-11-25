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

    private var sides: [MatchSide]

    /// If this set has ended
    var isEnd: Bool {
        winner != nil
    }

    /// List of games in this set
    var games: [Game] = []

    /// Current running game of this set
    var curGame: Game {
        return games[curGameIndex]
    }

    /// index of the current game of this set
    var curGameIndex: Int {
        self.games.count {
            $0.isEnd
        }
    }

    /// If this set uses the tiebreaker system or not
    var usesTieBreaker: Bool

    /// The winner of this set, returns `nil` if no winner is set
    var winner: MatchSide? {
        guard sides.count == 2 else { return nil }

        let first = gamesWon(by: sides[0])
        let second = gamesWon(by: sides[1])

        if first >= 6 && (usesTieBreaker ? (first - second >= 2) : true) {
            return sides[0]
        }
        if second >= 6 && (usesTieBreaker ? (second - first >= 2) : true) {
            return sides[1]
        }
        return nil
    }

    /// Returns who is currently winning in this match, returning nil when tied
    var whoIsWinning: MatchSide? {
        guard sides.count == 2 else { return nil }
        let first = gamesWon(by: sides[0])
        let second = gamesWon(by: sides[1])

        if first == second { return nil }
        return first > second ? sides[0] : sides[1]
    }

    /// Dictionary of points per side of this set
    var pointsPerSide: [MatchSide: Int] {

        var tmpSides: [MatchSide: Int] = [:]

        tmpSides[sides[0]] = 0
        tmpSides[sides[1]] = 0

        for game in games {
            if !game.isEnd {
                continue
            }
            for point in game.points {
                tmpSides[point.matchSide]! += 1
            }
        }

        return tmpSides
    }

    init(matchSides: [MatchSide], useTieBreaker: Bool, whoServes: Player? = nil) {
        self.sides = matchSides
        self.usesTieBreaker = useTieBreaker
        self.games = [
            Game(matchSides: matchSides, whoServes: whoServes)
        ]
    }

    /// Internal function to check how many games won on this set by side
    private func gamesWon(by side: MatchSide) -> Int {
        games.filter { $0.winner?.id == side.id }.count
    }

    /// Starts a new game on this set, checking if the current game truly has ended
    func startNextGame() throws {
        guard let currentGame = games.last, currentGame.isEnd else {
            throw MatchSetError.currentGameNotFinished
        }

        games.append(
            Game(matchSides: sides)
        )

    }

}

extension MatchSet {
    /// Errors for MatchSet
    enum MatchSetError: String, Error {
        case currentGameNotFinished = "The current game has not finished yet!"
    }
}
