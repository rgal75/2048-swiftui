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
                        Text("\(value)")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            .padding(4)
                            .background(Color.orange.opacity((sqrt(Double(value)) + 5) / 11))
                            .foregroundColor(.white)
                            .cornerRadius(8)
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
            game.userDidSwipe(translation: gesture.translation)
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
}

#Preview {
    GameView()
}
