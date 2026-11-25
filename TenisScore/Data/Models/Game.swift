//
//  Games.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData


/// Model that represents one game
@Model
class Game {
    
    /// The identificator for this game
    @Attribute(.unique)
    var id: UUID = UUID()
    
    /// The points for this current game
    var points: [GameSidePoints]
    
    /// Who is serving on this current game
    var whoServes: Player
    
    /// If this is the tie breaker game for a set
    var isImTieBreak: Bool
    
    
    /// If this game has ended yet
    var isEnd: Bool {
        let minimumPointsToWin = isImTieBreak ? 7 : 4
        let highestScore = points.map(\.points).max() ?? 0
        let lowestScore = points.map(\.points).min() ?? 0

        return highestScore >= minimumPointsToWin &&
            highestScore - lowestScore >= 2
    }
    
    /// Returns the side that is currently winning
    var whoIsWinning: MatchSide {
        if points[0].points > points[1].points {
            return points[0].matchSide
        } else {
            return points[1].matchSide
        }
    }
    
    /// Returns who is the winner of this game, returning `nil` if no winner has been decided yet
    var winner: MatchSide? {
        if isEnd {
            return whoIsWinning
        } else {
            return nil
        }
    }
    
    init(matchSides: [MatchSide], whoServes: Player? = nil, isImTieBreak: Bool = false) {
        
        self.points = [
            GameSidePoints(matchSide: matchSides[0]),
            GameSidePoints(matchSide: matchSides[1])
        ]
        
        self.isImTieBreak = isImTieBreak
        
        guard let whoServes = whoServes else {
            self.whoServes = matchSides.randomElement()!.players.randomElement()!
            return
        }
        
        self.whoServes = whoServes
    }
    
    /// Increment point for a side based on the side
    func incrementPoint(for side: MatchSide) {
        for point in points {
            if point.matchSide == side {
                point.points += 1;
                return
            }
        }
    }
    
    /// Increment point for a side based on the side ID
    func incrementPoint(sideId: UUID){
        for point in points {
            if point.matchSide.id == sideId{
                point.points += 1
                return
            }
        }
    }
    
    /// Increment point for a side based on the side's name
    func incrementPoint(sideName: String){
        for point in points {
            if point.matchSide.name == sideName{
                point.points += 1
                return
            }
        }
    }
    
    /// Decrement point for a side based on the side
    func decrementPoint(for side: MatchSide) {
        for point in points {
            if point.matchSide == side && point.points >= 1 {
                point.points -= 1;
                return
            }
        }
    }
    
    /// Decrement point for a side based on the side's ID
    func decrementPoint(sideId: UUID){
        for point in points {
            if point.matchSide.id == sideId && point.points >= 1{
                point.points -= 1
                return
            }
        }
    }
    
    /// Decrement point for a side based on the side's name
    func decrementPoint(sideName: String){
        for point in points {
            if point.matchSide.name == sideName && point.points >= 1{
                point.points -= 1
                return
            }
        }
    }
}
