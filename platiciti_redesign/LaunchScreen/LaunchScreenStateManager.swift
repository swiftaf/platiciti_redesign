//
//  LaunchScreenStateManager.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//

import Foundation
import SwiftUI
import GameKit


final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep
    
    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished
        }
    }
}
