//
//  MatchSide.swift
//  TenisScore
//
//  Created by João Duque Nardelli Wandermuren on 23/11/26.
//

import Foundation
import SwiftData

/// Model representing a side in a match
@Model
class MatchSide {

    /// Unique Identifier for this match side
    @Attribute(.unique)
    var id: UUID = UUID()
    var name: String
    /// List of players in this side
    var players: [Player]

    init(name: String, players: [Player]) {
        self.name = name
        self.players = players
    }
}

/// Extension
extension MatchSide {
    public static func makeSides(
        players: [Player],
        playerQuantity: MatchPlayerQuantity,
        randomizePlayers: Bool = true
    ) throws -> [MatchSide] {

        switch playerQuantity {
        case .singles:
            if players.count != 2 {
                throw MatchSide.MatchSideError.wrongNumberOfPlayer
            }

            if randomizePlayers {
                let player1 = Int.random(in: 0...1)

                let player2 = abs((player1 - 1))

                return [
                    MatchSide(players: [players[player1]]),
                    MatchSide(players: [players[player2]]),
                ]
            } else {
                return [
                    MatchSide(players: [players[0]]),
                    MatchSide(players: [players[1]]),
                ]
            }

        case .pairs:
            if players.count != 4 {
                throw MatchSide.MatchSideError.wrongNumberOfPlayer
            }

            if randomizePlayers {
                var curPlayers: [Int] = []

                while curPlayers.count < 4 {

                    let curNumber = Int.random(in: 0...3)

                    if curPlayers.contains(curNumber) {
                        continue
                    }

                    curPlayers.append(curNumber)
                }

                return [
                    MatchSide(players: [
                        players[curPlayers[0]], players[curPlayers[1]],
                    ]),
                    MatchSide(players: [
                        players[curPlayers[2]], players[curPlayers[3]],
                    ]),
                ]

            } else {
                return [
                    MatchSide(players: [players[0], players[1]]),
                    MatchSide(players: [players[2], players[3]]),
                ]
            }
        }

    }

    enum MatchSideError: String, Error {
        case wrongNumberOfPlayer =
            "Wrong ammount of players while making MatchSides"
    }
}
