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
    /// Function to make sides from team names, playes, player quantity and if they should be random
    /// Parameters:
    ///     - teamNames: The names of the two sides
    ///     - players: The players to add to the teams
    ///     - playerQuantity: Quantity of players per side
    ///     - randomizePlayers: If the players should be randomized when defining both sides
    public static func makeSides(
        teamNames: [String],
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
                    MatchSide(name: teamNames[0], players: [players[player1]]),
                    MatchSide(name: teamNames[1], players: [players[player2]]),
                ]
            } else {
                return [
                    MatchSide(name: teamNames[0], players: [players[0]]),
                    MatchSide(name: teamNames[1], players: [players[1]]),
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
                    MatchSide(
                        name: teamNames[0],
                        players: [
                            players[curPlayers[0]], players[curPlayers[1]],
                        ]
                    ),
                    MatchSide(
                        name: teamNames[1],
                        players: [
                            players[curPlayers[2]], players[curPlayers[3]],
                        ]
                    ),
                ]

            } else {
                return [
                    MatchSide(name: teamNames[0], players: [players[0], players[1]]),
                    MatchSide(name: teamNames[1], players: [players[2], players[3]]),
                ]
            }
        }

    }

    /// Errors for MatchSide
    enum MatchSideError: String, Error {
        case wrongNumberOfPlayer =
            "Wrong ammount of players while making MatchSides"
    }
}
