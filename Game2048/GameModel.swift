//
//  GameModel.swift
//  Game2048
//
//  Created by Richard Gal on 2025. 03. 14..
//
import Foundation

@Observable
final class GameModel {
    let boardSize: Int
    var grid: [[Int]]
    init(boardSize: Int = 4) {
        self.boardSize = boardSize
        self.grid = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize)
        let randomRow1 = Int.random(in: 0..<boardSize)
        let randomCol1 = Int.random(in: 0..<boardSize)
        grid[randomRow1][randomCol1] = 2048
        
        var randomRow2: Int
        var randomCol2: Int
        repeat {
            randomRow2 = Int.random(in: 0..<boardSize)
            randomCol2 = Int.random(in: 0..<boardSize)
            if randomRow1 != randomRow2 || randomCol1 != randomCol2 {
                grid[randomRow2][randomCol2] = 2048
                break
            }
        } while (randomRow1 != randomRow2 || randomCol1 != randomCol2)
    }
    
    func userDidSwipe(translation: CGSize) {
        debugPrint("Swipe: \(translation.width), \(translation.height)")
    }
}
