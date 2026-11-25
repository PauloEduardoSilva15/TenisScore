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
        return games.count >= 6 && games.last!.isEnd == true
    }
    
    /// List of games in this set
    var games: [Game] = []
    
    /// Current game of this set
    var curGame: Int {
        self.games.count {
            $0.isEnd
        }
    }
    
    var winner: MatchSide? {
        if isEnd {
            return whoIsWinning
        } else {
            return nil
        }
    }
    
    var whoIsWinning: MatchSide {
        let first = gamesWon(by: sides[0])
        let second = gamesWon(by: sides[1])
        
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
        if (!games[curGame].isEnd) {
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
