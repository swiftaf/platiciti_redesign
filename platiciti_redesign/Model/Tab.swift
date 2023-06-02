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
    TabItem(text: "Home", icon: "house.fill", tab: .games, color: .purple),
    TabItem(text: "Progress", icon: "chart.bar.fill", tab: .calHist, color: .blue),
    TabItem(text: "Accessibility", icon: "figure.wave.circle.fill", tab: .shareRes, color: .indigo),
    TabItem(text: "About", icon: "apps.iphone", tab: .gameCent, color: Color("Color 2"))
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
