//
//  TestPoints.swift
//  TenisScoreTests
//
//  Created by João Duque Nardelli Wandermuren on 25/11/26.
//

import Testing

@testable import TenisScore

@Suite("Test point, game and set systems from Match")
struct TestPoints {

    static let players = [Player(name: "Nome 1"), Player(name: "Nome 2")]

    @Test(
        "Make match with wrong number of players",
        arguments: [
            (1, MatchPlayerQuantity.singles), (3, MatchPlayerQuantity.singles),
            (1, MatchPlayerQuantity.pairs), (3, MatchPlayerQuantity.pairs),
        ]
    )
    func makeMatchWithProperNumber(
        howMany: Int,
        playerQuantity: MatchPlayerQuantity
    ) throws {
        var playerList: [Player] = []

        for i in 1...howMany {
            playerList.append(Player(name: "Nome " + String(i)))
        }

        #expect(throws: MatchSide.MatchSideError.wrongNumberOfPlayer) {
            _ = try Match(
                players: playerList,
                playerQuantity: playerQuantity,
                setQuantity: .three
            )
        }
    }

    @Test("Add point to a match")
    func testAddingPoints() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        //        let side2 = match.sides[1]

        try match.incrementPoints(for: side1)

        let set = match.sets[match.curSetIndex]
        let game = set.games[set.curGameIndex]

        #expect(game.whoIsWinning == side1)
    }

    @Test("Remove points from a match")
    func testRemovingPoints() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        let side2 = match.sides[1]

        // Add points to both
        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        // Remove point from 1
        try match.decrementPoints(for: side1)

        let set = match.sets[match.curSetIndex]
        let game = set.games[set.curGameIndex]

        // So now side2 should have 1 and side1 should have 0, so side2 will be winning!
        #expect(game.whoIsWinning == side2)
    }

    @Test("Roll over to next game")
    func rollToNextGame() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        //        let side2 = match.sides[1]

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side1)
        //        try match.incrementPoints(for: side1)

        let set = match.sets[match.curSetIndex]
        //        let game = set.games[set.curGame]

        #expect(set.curGameIndex == 1)
    }

    @Test("Don't roll over to next game on tie")
    func dontRollToNextGameOnTie() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        let side2 = match.sides[1]

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)
        //Make it tied

        // Shouldn't roll over
        try match.incrementPoints(for: side1)

        let set = match.sets[match.curSetIndex]
        //        let game = set.games[set.curGame]

        #expect(set.curGameIndex == 0)
    }

    @Test("Roll over when scoring on advantage")
    func rollWhenScoringOnAdvantage() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        let side2 = match.sides[1]

        let set = match.sets[match.curSetIndex]
        //        let game = set.games[set.curGame]

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)
        //Make it tied

        // Shouldn't roll over
        try match.incrementPoints(for: side1)
        #expect(set.curGameIndex == 0)

        // then rolls over cuz 2 above
        try match.incrementPoints(for: side1)

        #expect(set.curGameIndex == 1)
    }

    @Test("Don't roll over when scoring against advantage")
    func DontRollWhenScoringAgainstAdvantage() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        let side2 = match.sides[1]

        let set = match.sets[match.curSetIndex]
        //        let game = set.games[set.curGame]

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side2)
        //Make it tied

        // Shouldn't roll over
        try match.incrementPoints(for: side1)
        #expect(set.curGameIndex == 0)

        // still shouldn't roll over because tie
        try match.incrementPoints(for: side2)

        #expect(set.curGameIndex == 0)
    }

    @Test("Roll over to next set when a side wins 6 games")
    func rollSetOnSixGames() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        //        let side2 = match.sides[1]

        //        let set = match.sets[match.curSetIndex]
        //        let game = set.games[set.curGame]

        let numOfPoints = 6 * 4
        for _ in 0..<numOfPoints {
            try match.incrementPoints(for: side1)
        }

        #expect(match.curSetIndex == 1)
    }

    @Test(
        "Don't roll over to next set when both sides wins 5 games and one scores"
    )
    func dontRollSetOnGamesTiePlusOne() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        let side2 = match.sides[1]

        let set = match.sets[match.curSetIndex]
        for _ in 0..<3 {
            for _ in 0..<4 {
                try match.incrementPoints(for: side1)
            }
            for _ in 0..<4 {
                try match.incrementPoints(for: side2)
            }
        }

        // Make sure it actually tied
        #expect(match.curSetIndex == 0)
        #expect(set.curGameIndex == 6)

        try match.incrementPoints(for: side1)

        // Make sure it didnt roll over to next gane
        #expect(set.curGameIndex == 6)
    }

    @Test("One of the side wins", arguments: [0, 1])
    func oneOfTheSideWins(side: Int) throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        for _ in 1...(2 * 6 * 4) {
            try match.incrementPoints(for: match.sides[side])
        }

        #expect(match.winner != nil)
        #expect(match.winner == match.sides[side])
    }

    @Test("Return right number of points of game on match model")
    func returnRightNumberOfPointsOnGame() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        let side1 = match.sides[0]
        let side2 = match.sides[1]

        try match.incrementPoints(for: side1)
        try match.incrementPoints(for: side1)

        try match.incrementPoints(for: side2)

        #expect(match.curGamePointPerSide[side1] == 2)
        #expect(match.curGamePointPerSide[side2] == 1)
    }

    @Test("Without a tie break, 6–5 continues and 7–5 wins the set")
    func advantageSetNeedsTwoGameLead() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three,
            tieBreaker: false
        )
        let first = match.sides[0]
        let second = match.sides[1]
        let set = match.sets[0]

        for _ in 0..<5 {
            for _ in 0..<4 { try match.incrementPoints(for: first) }
            for _ in 0..<4 { try match.incrementPoints(for: second) }
        }
        for _ in 0..<4 { try match.incrementPoints(for: first) }

        #expect(set.winner == nil)
        #expect(match.sets.count == 1)
        #expect(set.games.last?.isImTieBreak == false)

        for _ in 0..<4 { try match.incrementPoints(for: first) }

        #expect(set.winner?.id == first.id)
        #expect(match.sets.count == 2)
    }

    @Test("At 6–6, a tie break decides the set 7–6")
    func tieBreakDecidesSet() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three,
            tieBreaker: true
        )
        let first = match.sides[0]
        let second = match.sides[1]
        let set = match.sets[0]

        for _ in 0..<6 {
            for _ in 0..<4 { try match.incrementPoints(for: first) }
            for _ in 0..<4 { try match.incrementPoints(for: second) }
        }

        #expect(set.winner == nil)
        #expect(set.games.last?.isImTieBreak == true)

        for _ in 0..<5 { try match.incrementPoints(for: second) }
        for _ in 0..<7 { try match.incrementPoints(for: first) }

        #expect(set.winner?.id == first.id)
        #expect(match.sets.count == 2)
    }

    @Test("Deciding set stays playable")
    func decidingSetStaysPlayable() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three,
            tieBreaker: true
        )
        let first = match.sides[0]
        let second = match.sides[1]

        for _ in 0...6 * 4 {
            try match.incrementPoints(for: first)
        }

        for _ in 0...6 * 4 {
            try match.incrementPoints(for: second)
        }

        try match.incrementPoints(for: first)

        #expect(match.curSetIndex == 2)
        #expect(match.isEnd == false)
        #expect(match.status == .inProgress)
        #expect(match.curGamePointPerSide[first] == 1)
    }

    @Test("Can't increment match after it has finished")
    func cantIncrementMatchAfterFinish() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        for _ in 1...(2 * 6 * 4) {
            try match.incrementPoints(for: match.sides[0])
        }

        #expect(match.winner != nil)
        #expect(match.winner == match.sides[0])

        #expect(throws: Match.MatchError.matchFinished) {
            try match.incrementPoints(for: match.sides[0])
        }

    }

    @Test("Can't decrement match after it has finished")
    func cantDecrementMatchAfterFinish() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )

        for _ in 1...(2 * 6 * 4) {
            try match.incrementPoints(for: match.sides[0])
        }

        #expect(match.winner != nil)
        #expect(match.winner == match.sides[0])

        #expect(throws: Match.MatchError.matchFinished) {
            try match.decrementPoints(for: match.sides[0])
        }

    }
}
