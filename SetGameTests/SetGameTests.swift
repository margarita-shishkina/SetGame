//
//  SetGameTests.swift
//  SetGameTests
//
//  Created by Margarita Sergeevna on 03/09/2018.
//  Copyright © 2018 Margarita Sergeevna. All rights reserved.
//

import XCTest
@testable import SetGame

class SetGameTests: XCTestCase {
    var game: SetGameModel!
    
    override func setUp() {
        super.setUp()
        game = SetGameModel()
    }
    
    override func tearDown() {
        game = nil
        super.tearDown()
    }
    
//    func testCardDeckCountIsValid() {
//        XCTAssertEqual(game.cardDeck.count, 81 - 12, "Count cards in deck is wrong")
//    }
    
    func testCardInGameCountIsValid() {
        XCTAssertEqual(game.cardsInGame.count, 12, "Count cards in game is wrong")
    }
    
    func testCardSelect() {
        game.chooseCard(at: 4)
        XCTAssert(game.cardsInGame[4] == game.selectedCards.first!, "Select card wrong")
    }
    
    func testCardDeselect() {
        game.chooseCard(at: 5)
        game.chooseCard(at: 5)
        XCTAssert(game.selectedCards.isEmpty, "Deselect card wrong")
    }
    
    func testCardMatch() {
        if let matchIndecies = Utils.findMatchIndecies(cards: game.cardsInGame) {
            game.chooseCard(at: matchIndecies[0])
            game.chooseCard(at: matchIndecies[1])
            game.chooseCard(at: matchIndecies[2])
            XCTAssert(game.selectedCardIsMatched(), "Match not working")
        }
    }
    
    func testFindAllMatch() {
        var match = 0
    
        while true {
            let matchIndecies = Utils.findMatchIndecies(cards: game.cardsInGame)
            if matchIndecies == nil && game.cardDeck.isEmpty { break }

            if let matchIndecies = matchIndecies {
                game.chooseCard(at: matchIndecies[0])
                game.chooseCard(at: matchIndecies[1])
                game.chooseCard(at: matchIndecies[2])
                
                let notMatchIndex = Utils.getRandNotMatchIndex(mathedIndecies: matchIndecies, cards: game.cardsInGame)
                game.chooseCard(at: notMatchIndex)
                game.chooseCard(at: notMatchIndex)
                match += 1
            } else {
                game.deal3MoreCards()
            }
        }
        
        let countNotMatchCard = game.cardsInGame.compactMap({ $0 }).count
        let allCards = match * 3 + countNotMatchCard
        
        XCTAssert(allCards == 81, "Find all match failed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
