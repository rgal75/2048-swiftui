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
    
    init(initialBoard: GameBoard) {
        self.boardSize = (width: initialBoard[0].count, height: initialBoard.count)
        self.board = initialBoard
    }
    
    func userDidSwipe(translation: CGSize) {
        if abs(translation.width) > abs(translation.height) {
            if translation.width > 0 {
                slideRight()
            } else {
                slideLeft()
            }
        } else {
            if translation.height > 0 {
                slideDown()
            } else {
                slideUp()
            }
        }
    }
    
    private func slideUp() {
        for rowIdx in 0..<boardSize.height {
            let row = board[rowIdx]
            for colIdx in 0..<boardSize.width {
                let value = row[colIdx]
                guard value != 0 else { continue }
                var currentRowIdx = rowIdx
                while currentRowIdx > 0, board[currentRowIdx - 1][colIdx] == 0 {
                    board[currentRowIdx][colIdx] = 0
                    board[currentRowIdx - 1][colIdx] = value
                    currentRowIdx -= 1
                }
                if currentRowIdx > 0 && board[currentRowIdx - 1][colIdx] == value {
                    board[currentRowIdx - 1][colIdx] += value
                    board[currentRowIdx][colIdx] = 0
                }
            }
        }
        addRandomTile()
    }
    
    private func slideDown() {
        for rowIdx in (0..<boardSize.height).reversed() {
            let row = board[rowIdx]
            for colIdx in 0..<boardSize.width {
                let value = row[colIdx]
                guard value != 0 else { continue }
                var currentRowIdx = rowIdx
                while currentRowIdx < boardSize.height - 1, board[currentRowIdx + 1][colIdx] == 0 {
                    board[currentRowIdx][colIdx] = 0
                    board[currentRowIdx + 1][colIdx] = value
                    currentRowIdx += 1
                }
                if currentRowIdx < boardSize.height - 1 && board[currentRowIdx + 1][colIdx] == value {
                    board[currentRowIdx + 1][colIdx] += value
                    board[currentRowIdx][colIdx] = 0
                }
            }
        }
        addRandomTile()
    }
    
    private func slideLeft() {
        for rowIdx in 0..<boardSize.height {
            let row = board[rowIdx]
            for colIdx in 0..<boardSize.width {
                let value = row[colIdx]
                guard value != 0 else { continue }
                var currentColIdx = colIdx
                while currentColIdx > 0, board[rowIdx][currentColIdx - 1] == 0 {
                    board[rowIdx][currentColIdx] = 0
                    board[rowIdx][currentColIdx - 1] = value
                    currentColIdx -= 1
                }
                if currentColIdx > 0 && board[rowIdx][currentColIdx - 1] == value {
                    board[rowIdx][currentColIdx - 1] += value
                    board[rowIdx][currentColIdx] = 0
                }
            }
        }
        addRandomTile()
    }
    
    private func slideRight() {
        for rowIdx in 0..<boardSize.height {
            let row = board[rowIdx]
            for colIdx in (0..<boardSize.width).reversed() {
                let value = row[colIdx]
                guard value != 0 else { continue }
                var currentColIdx = colIdx
                while currentColIdx < boardSize.width - 1, board[rowIdx][currentColIdx + 1] == 0 {
                    board[rowIdx][currentColIdx] = 0
                    board[rowIdx][currentColIdx + 1] = value
                    currentColIdx += 1
                }
                if currentColIdx < boardSize.width - 1 && board[rowIdx][currentColIdx + 1] == value {
                    board[rowIdx][currentColIdx + 1] += value
                    board[rowIdx][currentColIdx] = 0
                }
            }
        }
        addRandomTile()
    }
    
    private func addRandomTile() {
        let emptyTiles = self.emptyTiles(on: board)
        guard !emptyTiles.isEmpty else { return }
        let randomIndex = Int.random(in: 0..<emptyTiles.count)
        let (rowIdx, colIdx) = emptyTiles[randomIndex]
        board[rowIdx][colIdx] = 2
    }
    
    private func emptyTiles(on board: [[Int]]) -> [(Int, Int)] {
        var emptyTiles = [(Int, Int)]()
        
        for rowIdx in 0..<boardSize.height {
            for colIdx in 0..<boardSize.width {
                if board[rowIdx][colIdx] == 0 {
                    emptyTiles.append((rowIdx, colIdx))
                }
            }
        }
        
        return emptyTiles
    }
}

private func makeBoard(size: BoardSize) -> GameBoard {
    var board = Array(repeating: Array(repeating: 0, count: size.width), count: size.height)
    let random1 = Int.random(in: 0..<size.width * size.height)
    var random2: Int
    repeat {
        random2 = Int.random(in: 0..<size.width * size.height)
    } while (random1 == random2)
    board[random1 / size.width][random1 % size.width] = 2
    board[random2 / size.width][random2 % size.width] = 2
    return board
}
