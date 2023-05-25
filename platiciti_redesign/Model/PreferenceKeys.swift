//
//  PreferenceKeys.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/23/23.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
