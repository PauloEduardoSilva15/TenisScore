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
    
    /// Points for each side of the game
    var points: [GameSidePoints]
    
    /// Who serves during this game
    var whoServes: MatchSide
    
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
}
