//
//  SidePoints.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

@Model
class SidePoints {
    @Attribute(.unique)
    var id: UUID
    
    var points: Int
    
    var matchSide: MatchSide
    
    init(id: UUID, points: Int, matchSide: MatchSide) {
        self.id = id
        self.points = points
        self.matchSide = matchSide
    }
}
