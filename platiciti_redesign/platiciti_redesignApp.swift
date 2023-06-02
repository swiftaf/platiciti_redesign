//
//  platiciti_redesignApp.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//


import SwiftUI
import GameKit

@main
struct PlasticitiApp: App {
    
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @StateObject var model = Model()
    
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    @State public var showGameCenterAccessPoint = false
    
    let localPlayer = GKLocalPlayer.local
    func authenticateUser() {
        localPlayer.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            GCController.startWirelessControllerDiscovery()
            GKAccessPoint.shared.isActive = localPlayer.isAuthenticated
        }
    }
    
    
        
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .environmentObject(model)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .onAppear {
                        authenticateUser()
//                        if showGameCenterAccessPoint {
//                            GameCenterDashboardView()
//                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                         }
                    }
                
                if launchScreenState.state != .finished {
                    
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }

    }
}
