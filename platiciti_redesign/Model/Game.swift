//
//  Course.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/23/23.
//

import SwiftUI

struct Game: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var logo: String
}

var games = [
    Game(title: "Wordley", subtitle: "Six chances to guess a five-letter word", text: "Play the world-famous game, track your progress, and share your scores with your friends", image: "3dWordle", logo: "wordleArt"),
    Game(title: "SlideIt", subtitle: "Slide numbers around to combine them", text: "Comine blocks of like numbers to reach higher and higher goals", image: "3dWordle", logo: "wordleArt"),
    Game(title: "Tic-Tac-Toe", subtitle: "X's, O's, and iMessages", text: "Play the classic game with your friends in real-time or through iMessages", image: "3dWordle", logo: "wordleArt")
]
