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
    
    var points: [SidePoints]
    
    var whoServes: MatchSide
    
    var whoIsWinning: MatchSide {
        if points[0].points > points[1].points {
            return points[0].matchSide
        } else {
            return points[1].matchSide
        }
    }
    
    init(id: UUID, points: [SidePoints], whoServes: MatchSide?) {
        self.id = id
        self.points = points
        
        guard let whoServes = whoServes else {
            self.whoServes = points.randomElement()!.matchSide
            return
        }
        
        self.whoServes = whoServes
    }
}
