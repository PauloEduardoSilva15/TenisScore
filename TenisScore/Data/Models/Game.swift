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
    
    var points: [GameSidePoints]
    
    var whoServes: Player
    
    var isImTieBreak: Bool
    
    
    var isEnd: Bool {
        let minimumPointsToWin = isImTieBreak ? 7 : 4
        let highestScore = points.map(\.points).max() ?? 0
        let lowestScore = points.map(\.points).min() ?? 0

        return highestScore >= minimumPointsToWin &&
            highestScore - lowestScore >= 2
    }
    
    
    var whoIsWinning: MatchSide {
        if points[0].points > points[1].points {
            return points[0].matchSide
        } else {
            return points[1].matchSide
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
    
    func incrementPoint(sideId: UUID){
        for point in points {
            if point.matchSide.id == sideId{
                point.points += 1
                return
            }
        }
    }
    func incrementPoint(sideName: String){
        for point in points {
            if point.matchSide.name == sideName{
                point.points += 1
                return
            }
        }
    }
    func decrementPoint(sideId: UUID){
        for point in points {
            if point.matchSide.id == sideId && point.points >= 1{
                point.points -= 1
                return
            }
        }
    }
    func decrementPoint(sideName: String){
        for point in points {
            if point.matchSide.name == sideName && point.points >= 1{
                point.points -= 1
                return
            }
        }
    }
}
