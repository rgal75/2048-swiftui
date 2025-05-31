//
//  GameView.swift
//  Game2048
//
//  Created by Richard Gal on 2025. 03. 14..
//

import SwiftUI

struct GameView: View {
    @State var game = GameModel()
    var body: some View {
        VStack {
            ForEach(0..<game.boardSize.height, id: \.self) { row in
                HStack {
                    ForEach(0..<game.boardSize.width, id: \.self) { col in
                        let value = game.board[row][col]
                        TileView(value: value, isMerged: isTileMerged(row: row, col: col), row: row, col: col)
                    }
                }
            }
            Text("\(gameResult)")
                .font(.headline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .gesture(DragGesture().onEnded({ gesture in
            withAnimation {
                game.userDidSwipe(translation: gesture.translation)
            }
        }))
    }
    
    private var gameResult: String {
        switch game.gameResult {
        case .won:
            return "You won!"
        case .lost:
            return "Game over!"
        case .ongoing:
            return ""
        }
    }
    
    private func isTileMerged(row: Int, col: Int) -> Bool {
        return game.mergedTiles.contains { (pos: (Int, Int)) -> Bool in pos.0 == row && pos.1 == col }
    }
}

private struct TileView: View {
    let value: Int
    let isMerged: Bool
    let row: Int
    let col: Int
    
    var body: some View {
        Text("\(value)")
            .font(.title)
            .frame(width: 50, height: 50)
            .minimumScaleFactor(0.1)
            .lineLimit(1)
            .padding(4)
            .background(Color.orange.opacity((sqrt(Double(value)) + 5) / 11))
            .foregroundColor(.white)
            .cornerRadius(8)
            .id(value == 0 ? "empty-\(row)-\(col)" : "tile-\(row)-\(col)-\(value)")
            .if(isMerged) { view in
                view.transition(.scale.combined(with: .opacity))
                    .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5), value: value)
            }
    }
}

// Conditional view modifier for SwiftUI
extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    GameView()
}
