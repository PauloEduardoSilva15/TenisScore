//
//  SidePoints.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

/// Model representing the points of a side
@Model
class GameSidePoints {
    /// Unique Identifier for this side's points
    @Attribute(.unique)
    var id: UUID = UUID()
    
    /// Points for a side
    var points: Int
    
    /// The side that this class refers to
    var matchSide: MatchSide
    
    init(points: Int, matchSide: MatchSide) {
        self.points = points
        self.matchSide = matchSide
    }
}
