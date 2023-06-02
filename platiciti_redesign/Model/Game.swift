//
//  Course.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/23/23.
//

import SwiftUI
import ComposableArchitecture

struct Game: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String
    var gameView: AnyView
    var tagLine: String
}

var featuredGames = [
     Game(title: "SlideIt", subtitle: "Slide numbers around to combine them", text: "Comine blocks of like numbers to reach higher and higher goals", image: "3DslideitRound", background: "launchScreenBgIpad", logo: "logoSlideIt", gameView: AnyView(GameView2048()), tagLine:"Slide in any direction.  Combine like numbers."),
     Game(title: "Tic-Tac-Toe", subtitle: "X's, O's, and iMessages", text: "Play the classic game with your friends in real-time or through iMessages", image: "3Dttt", background: "launchScreenBgIpad", logo: "logoTtt", gameView: AnyView(ContentViewWordley()), tagLine:"Add to your 11 day streak!"),
     Game(title: "Wordley", subtitle: "Six chances to guess a five-letter word", text: "Play the world-famous game, track your progress, and share your scores with your friends", image: "3Dwordle", background: "launchScreenBgIpad", logo: "wordleArt", gameView: AnyView(ContentViewWordley()), tagLine:"Add to your 11 day streak!")
]

var games = [
//    Game(title: "Wordley", subtitle: "Six chances to guess a five-letter word", text: "Play the world-famous game, track your progress, and share your scores with your friends", image: "3dWordle", background: "launchScreenBgIpad", logo: "wordleArt", gameView: AnyView(GameView(store: Store(initialState: AppState(), reducer: appReducer, environment: AppEnv()))), tagLine:"Add to your 11 day streak!"),
    Game(title: "Wordley", subtitle: "Six chances to guess a five-letter word", text: "Play the world-famous game, track your progress, and share your scores with your friends", image: "3Dwordle", background: "launchScreenBgIpad", logo: "wordleArt", gameView: AnyView(ContentViewWordley()), tagLine:"Add to your 11 day streak!"),
    Game(title: "SlideIt", subtitle: "Slide numbers around to combine them", text: "Comine blocks of like numbers to reach higher and higher goals", image: "3DslideitRound", background: "launchScreenBgIpad", logo: "logoSlideIt", gameView: AnyView(GameView2048()), tagLine:"Slide in any direction.  Combine like numbers."),
    Game(title: "Tic-Tac-Toe", subtitle: "X's, O's, and iMessages", text: "Play the classic game with your friends in real-time or through iMessages", image: "3Dttt", background: "launchScreenBgIpad", logo: "logoTtt", gameView: AnyView(ContentViewTTT()), tagLine:"Play with 2 players or against AI")
]
