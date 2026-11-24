//
//  Games.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

@Model
class Game {
    @Attribute(.unique)
    var id: UUID
    
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
    
    
    var whoIsWinning: MatchSide {
        if points[0].points > points[1].points {
            return points[0].matchSide
        } else {
            return points[1].matchSide
        }
    }
    
    
    init(id: UUID, points: [GameSidePoints], whoServes: Player?, isImTieBreak: Bool = false) {
        self.id = id
        self.points = points
        self.isImTieBreak = isImTieBreak
        
        guard let whoServes = whoServes else {
            self.whoServes = points.randomElement()!.matchSide.players.randomElement()!
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
