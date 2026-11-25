//
//  Game.swift
//  TenisScore
//
//  Created by Paulo Eduardo Barbosa da Silva on 25/11/26.
//

import Testing
@testable import TenisScore

struct TestGame {
    // isEnd
    @Test("This game is not ended at creation")
    func gameIsNotEndedAtCreation() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides)
        game.points[0].points = 2
        game.points[1].points = 2
        #expect(!game.isEnd)
    }
    
    @Test("A regular game ends with four points and a two-point lead")
    func regularGameEndsWithTwoPointLead() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides)
        game.points[0].points = 4
        game.points[1].points = 2

        #expect(game.isEnd)
    }

    @Test("A tie-break ends with seven points and a two-point lead")
    func tieBreakEndsWithTwoPointLead() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides, isImTieBreak: true)
        game.points[0].points = 7
        game.points[1].points = 5

        #expect(game.isEnd)
    }

    @Test("A tie-break continues without a two-point lead")
    func tieBreakContinuesWithoutTwoPointLead() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides, isImTieBreak: true)
        game.points[0].points = 7
        game.points[1].points = 6

        #expect(!game.isEnd)
    }
    
    
    // WhoIsWinning
    @Test("The first team is Wining")
    func testWhosIsWiningInFirstIndex() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides)
        game.points[0].points = 5
        game.points[1].points = 4
        #expect(game.whoIsWinning == game.points.first?.matchSide)
    }
    @Test("The first team is Lose")
    func testWhosIsLoseInFirstIndex() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides)
        game.points[0].points = 4
        game.points[1].points = 5
        #expect(game.whoIsWinning != game.points.first?.matchSide)
    }
    @Test("The second team is Wining")
    func testWhosIsWiningInLastIndex() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides)
        game.points[0].points = 4
        game.points[1].points = 5
        #expect(game.whoIsWinning == game.points.last?.matchSide)
    }
    
    @Test("The second team is Lose")
    func testWhosIsLoseInLastIndex() throws {
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        let game = Game(matchSides: sides)
        game.points[0].points = 5
        game.points[1].points = 4
        #expect(game.whoIsWinning != game.points.last?.matchSide)
    }

    @Test("Incremented with id")
    func testIncrementedWithId() throws{
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        
        let game = Game(matchSides: sides)
        let id = (game.points.first?.matchSide.id)!
        let prevPoints = game.points.first!.points
        game.incrementPoint(sideId: id)
        #expect(game.points.first?.points == prevPoints + 1)
    }
    @Test("Incremented with name")
    func testIncrementedWithName() throws{
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        
        let game = Game(matchSides: sides)
        let name = (game.points.first?.matchSide.name)!
        let prevPoints = game.points.first!.points
        game.incrementPoint(sideName: name)
        #expect(game.points.first?.points == prevPoints + 1)
    }
    
    @Test("Decremented with id")
    func testDecrementedWithId() throws{
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        
        let game = Game(matchSides: sides)
        let id = (game.points.first?.matchSide.id)!
        game.points.first?.points = 1
        game.decrementPoint(sideId: id)
        #expect(game.points.first?.points == 0)
    }
    @Test("Decremented with id: points >= 0")
    func testDecrementedWithIdIsGreaterThanZero() throws{
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        
        let game = Game(matchSides: sides)
        let id = (game.points.first?.matchSide.id)!
        game.decrementPoint(sideId: id)
        #expect(game.points.first?.points == 0)
    }
    
    @Test("Decremented with name")
    func testDecrementedWithName() throws{
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        
        let game = Game(matchSides: sides)
        let name = (game.points.first?.matchSide.name)!
        game.points.first?.points = 1
        game.decrementPoint(sideName: name)
        #expect(game.points.first?.points == 0)
    }
    @Test("Decremented with name: points >= 0")
    func testDecrementedWithNameIsGreaterThanZero() throws{
        let sides: [MatchSide] = try MatchSide.makeSides(
            teamNames: ["Jorges", "Engenheiros"],
            players: [Player(name: "Jorge"), Player(name: "Ana")],
            playerQuantity: .singles,
            randomizePlayers: false
        )
        
        let game = Game(matchSides: sides)
        let name = (game.points.first?.matchSide.name)!
        game.decrementPoint(sideName: name)
        #expect(game.points.first?.points == 0)
    }

}
