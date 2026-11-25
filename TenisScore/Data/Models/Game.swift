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
        if points[0].points >= 4 || points[1].points >= 4 {
            if points[0].points - points[1].points >= 2 ||
            points[1].points - points[0].points >= 2{
                return true
            }
            
        }
        return false
    }
    
    /// Who is currently winning in this game
    var whoIsWinning: MatchSide {
        if points[0].points > points[1].points {
            return points[0].matchSide
        } else {
            return points[1].matchSide
        }
    }
    
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
    
    func incrementPoint(for side: MatchSide) {
        for point in points {
            if point.matchSide == side {
                point.points += 1;
                return
            }
        }
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
    
    func decrementPoint(for side: MatchSide) {
        for point in points {
            if point.matchSide == side && point.points >= 1 {
                point.points -= 1;
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
