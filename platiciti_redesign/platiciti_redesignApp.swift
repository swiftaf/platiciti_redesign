//
//  platiciti_redesignApp.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//

//import SwiftUI
//
//@main
//struct platiciti_redesignApp: App {
//    var body: some Scene {
//        WindowGroup {
//            AppTabNavigationView()
//        }
//    }
//}

import SwiftUI

@main
struct LaunchScreenTutorialApp: App {
    
    @StateObject var model = Model()
    
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .environmentObject(model)
                
//                if launchScreenState.state != .finished {
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }
    }
}
