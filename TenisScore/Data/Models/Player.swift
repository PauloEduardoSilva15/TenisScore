//
//  Player.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

@Model
class Player {
    @Attribute(.unique)
    var id: UUID
    
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
