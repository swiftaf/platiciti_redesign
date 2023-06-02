//
//  Progress.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/23/23.
//

import SwiftUI
import ComposableArchitecture

struct Item: Identifiable {
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

var items = [
//    Game(title: "Wordley", subtitle: "Six chances to guess a five-letter word", text: "Play the world-famous game, track your progress, and share your scores with your friends", image: "3dWordle", background: "launchScreenBgIpad", logo: "wordleArt", gameView: AnyView(GameView(store: Store(initialState: AppState(), reducer: appReducer, environment: AppEnv()))), tagLine:"Add to your 11 day streak!"),
    Item(title: "Wordley Progress", subtitle: "Six chances to guess a five-letter word", text: "Play the world-famous game, track your progress, and share your scores with your friends", image: "3Dwordle", background: "launchScreenBgIpad", logo: "wordleArt", gameView: AnyView(ContentViewWordley()), tagLine:"Add to your 11 day streak!"),
   
]
