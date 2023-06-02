//
//  ContentView.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//

import SwiftUI
import GameKit

struct ContentView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @AppStorage("selectedTab") var selectedTab: Tab = .games
    @EnvironmentObject var model: Model
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack(alignment: .bottom)  {
            switch selectedTab {
            case .games:
                HomeView()
            case .calHist:
                CalendarView()
            case .shareRes:
                SettingsView()
            case .gameCent:
                AboutView()
            }

            TabBar()
                .offset(y: model.showDetail ? 200 : 0)

        }
        .safeAreaInset(edge: .bottom, content: {
            Color.clear.frame(height: 44)
        })
        .task {
            try? await getDataFromApi()
            try? await Task.sleep(for: Duration.seconds(3))
            self.launchScreenState.dismiss()
        }
    }
    
    fileprivate func getDataFromApi() async throws {
        let googleURL = URL(string: "https://www.google.com")!
        let (_,response) = try await URLSession.shared.data(from: googleURL)
        print(response as? HTTPURLResponse)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LaunchScreenStateManager())
            .environmentObject(Model())
    }
}
