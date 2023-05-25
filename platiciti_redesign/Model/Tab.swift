//
//  Tab.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/22/23.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "All Games", icon: "gamecontroller", tab: .games, color: .purple),
    TabItem(text: "Play History", icon: "calendar", tab: .calHist, color: .blue),
    TabItem(text: "Share Results", icon: "star.bubble", tab: .shareRes, color: .indigo),
    TabItem(text: "Game Center", icon: "person.crop.circle", tab: .gameCent, color: .pink)
]

enum Tab: String {
    case games
    case calHist
    case shareRes
    case gameCent
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
