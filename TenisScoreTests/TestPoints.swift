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

    @Test("Add point to a match")
    func testAddingPoints() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )
        
        let side1 = match.sides[0]
//        let side2 = match.sides[1]
        
        match.incrementPoints(for: side1)
        
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
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        // Remove point from 1
        match.decrementPoints(for: side1)
        
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
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side1)
//        match.incrementPoints(for: side1)
        
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
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        //Make it tied
        
        // Shouldn't roll over
        match.incrementPoints(for: side1)
        
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
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        //Make it tied
        
        // Shouldn't roll over
        match.incrementPoints(for: side1)
        #expect(set.curGameIndex == 0)
        
        // then rolls over cuz 2 above
        match.incrementPoints(for: side1)
        
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
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side2)
        //Make it tied
        
        // Shouldn't roll over
        match.incrementPoints(for: side1)
        #expect(set.curGameIndex == 0)
        
        // still shouldn't roll over because tie
        match.incrementPoints(for: side2)
        
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
            match.incrementPoints(for: side1)
        }
        
        #expect(match.curSetIndex == 1)
    }
    
    @Test("Don't roll over to next set when both sides wins 5 games and one scores")
    func dontRollSetOnGamesTiePlusOne() throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )
        
        let side1 = match.sides[0]
        let side2 = match.sides[1]
        
        let set = match.sets[match.curSetIndex]
        for _ in 0..<5 {
            for _ in 0..<4 {
                match.incrementPoints(for: side1)
            }
            for _ in 0..<4 {
                match.incrementPoints(for: side2)
            }
        }
        
        // Make sure it actually tied
        #expect(set.curGameIndex == 10)
        for _ in 0..<4 {
            match.incrementPoints(for: side1)
        }

        // Make sure it didnt roll over to next gane
        #expect(match.curSetIndex == 0)
        #expect(set.curGameIndex == 11)
    }
    
    @Test("One of the side wins", arguments: [0, 1])
    func oneOfTheSideWins(side: Int) throws {
        let match = try Match(
            players: TestPoints.players,
            playerQuantity: .singles,
            setQuantity: .three
        )
        
        for _ in 1...(2 * 6 * 4) {
            match.incrementPoints(for: match.sides[side])
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
        
        
        match.incrementPoints(for: side1)
        match.incrementPoints(for: side1)
        
        
        match.incrementPoints(for: side2)
        
        #expect(match.curGamePointPerSide[side1] == 2)
        #expect(match.curGamePointPerSide[side2] == 1)
    }
    
}
