//
//  GameModel.swift
//  Game2048
//
//  Created by Richard Gal on 2025. 03. 14..
//
import Foundation

typealias GameBoard = [[Int]]
typealias BoardSize = (width: Int, height: Int)

@Observable
final class GameModel {
    let boardSize: BoardSize
    var board: GameBoard
    init(boardSize: BoardSize = (width: 4, height: 4)) {
        self.boardSize = boardSize
        self.board = makeBoard(size: boardSize)
    }
    
    func userDidSwipe(translation: CGSize) {
        debugPrint("Swipe: \(translation.width), \(translation.height)")
    }
    
}

private func makeBoard(size: BoardSize) -> GameBoard {
    var board = Array(repeating: Array(repeating: 0, count: size.width), count: size.height)
    let randomRow1 = Int.random(in: 0..<size.width)
    let randomCol1 = Int.random(in: 0..<size.height)
    board[randomRow1][randomCol1] = 2
    
    var randomRow2: Int
    var randomCol2: Int
    repeat {
        randomRow2 = Int.random(in: 0..<size.width)
        randomCol2 = Int.random(in: 0..<size.height)
        if randomRow1 != randomRow2 || randomCol1 != randomCol2 {
            board[randomRow2][randomCol2] = 2
            break
        }
    } while (randomRow1 != randomRow2 || randomCol1 != randomCol2)
    
    return board
}
