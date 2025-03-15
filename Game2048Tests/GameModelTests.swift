//
//  GameModelTests.swift
//  Game2048Tests
//
//  Created by Richard Gal on 2025. 03. 15..
//

import Testing

@testable import Game2048

struct GameModelTests {

    @Test("Creates a rectangular board")
    func testCreateBoard() async throws {
        let sut = GameModel(boardSize: (width: 6, height: 6))
        
        #expect(sut.board.count == 6, "Expected a board with 6 rows, got \(sut.board.count)")
        sut.board.enumerated().forEach { (rowIdx, row) in
            #expect(row.count == 6, "Expected row \(rowIdx) of size 6, got \(String(describing: row.count))")
        }
    }

    @Test("The board is filled with 0's having 2's at two positions")
    func testInitialBoard() async throws {
        let sut = GameModel(boardSize: (width: 10, height: 10))
        let twosCount = numberOfTwosOnBoard(sut.board)
        #expect(twosCount == 2, "Expected 2 twos on the board, got \(twosCount)")
    }
    
    private func numberOfTwosOnBoard(_ board: [[Int]]) -> Int {
        var twosCount = 0
        
        board.flatMap(\.self).forEach { cell in
            if cell == 2 {
                twosCount += 1
            }
        }
        
        return twosCount
    }
}
