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
    
    let localPlayer = GKLocalPlayer.local
    func authenticateUser() {
        localPlayer.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
//            GKAccessPoint.shared.isActive = self.localPlayer.isAuthenticated
        }
    }

    @MainActor func dismiss() {
        Task {
            state = .secondStep
            
            authenticateUser()

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished
        }
    }
}
