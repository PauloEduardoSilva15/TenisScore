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
        if points[0].points > 4 || points[1].points > 4{
            if points[0].points - points[1].points == 2 ||
            points[1].points - points[0].points == 2{
                return true
            }
            
        }
        return false
    }
    
    
    /// Who is winning currently in this game
    var whoIsWinning: MatchSide {
        if points[0].points > points[1].points {
            return points[0].matchSide
        } else {
            return points[1].matchSide
        }
    }
    
    init(matchSides: [MatchSide], whoServes: MatchSide? = nil) {
        
        self.points = [
            GameSidePoints(matchSide: matchSides[0]),
            GameSidePoints(matchSide: matchSides[1])
        ]
        
        guard let whoServes = whoServes else {
            self.whoServes = matchSides.randomElement()!
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
