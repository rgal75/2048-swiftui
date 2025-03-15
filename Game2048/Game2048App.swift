//
//  Game2048App.swift
//  Game2048
//
//  Created by Richard Gal on 2025. 03. 14..
//

import SwiftUI

// Game descriptions: https://rosettacode.org/wiki/2048
@main
struct Game2048App: App {
    var body: some Scene {
        WindowGroup {
            GameView()
        }
    }
}
