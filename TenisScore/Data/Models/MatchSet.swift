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
    
    var curGame: Game {
        return games[curGameIndex]
    }
    
    /// index of the current game of this set
    var curGameIndex: Int {
        self.games.count {
            $0.isEnd
        }
    }
    
    var winner: MatchSide? {
        guard sides.count == 2 else { return nil }

        let first = gamesWon(by: sides[0])
        let second = gamesWon(by: sides[1])

        if first >= 6 && first - second >= 2 { return sides[0] }
        if second >= 6 && second - first >= 2 { return sides[1] }
        return nil
    }
    
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
            if (!game.isEnd) {
                continue
            }
            for point in game.points {
                tmpSides[point.matchSide]! += 1
            }
        }
        
        return tmpSides
    }
 
    init(matchSides: [MatchSide], whoServes: Player? = nil) {
        self.sides = matchSides
        self.games = [
            Game(matchSides: matchSides, whoServes: whoServes)
        ]
    }
    
    private func gamesWon(by side: MatchSide) -> Int {
        games.filter { $0.winner?.id == side.id }.count
    }
    
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
    enum MatchSetError: String, Error {
        case currentGameNotFinished = "The current game has not finished yet!"
    }
}
