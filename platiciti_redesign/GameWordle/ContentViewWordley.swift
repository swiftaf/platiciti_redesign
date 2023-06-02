/// Copyright (c) 2022 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import GameKit

struct ContentViewWordley: View {
  @StateObject var game = GuessingGame()
  @State private var showResults = false
  @State private var showStats = false
  @Environment(\.scenePhase) var scenePhase
    
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
    
  var body: some View {
    VStack {

      GameBoardView(game: game)
      
      KeyboardViewWordley(game: game)
      Spacer()
      ActionBarView(
        showStats: $showStats,
        game: game
      )
      .frame(height: 50, alignment: .bottom)
    }
    .sheet(isPresented: $showResults) {
        GameResultView(game: game).opacity(0.8)
            .presentationDetents([.large,.medium])
    }
    .sheet(isPresented: $showStats) {
        StatisticsView(stats: GameStatistics(gameRecord: game.gameRecord)).opacity(0.8)
            .presentationDetents([.large])
    }
      // 1
      .onChange(of: game.status) { newStatus in
        // 2
        if newStatus == .won || newStatus == .lost {
            
            if newStatus == .won {
                // Game Center acheivements
                // won at wordley
                let achievment = GKAchievement(identifier: "grp.wonAtWordley")
                achievment.percentComplete = 100
                achievment.showsCompletionBanner = true
                GKNotificationBanner.show(withTitle:"Hooray",
                                          message:"You won at Wordley!",
                                          completionHandler: nil)
                GKAchievement.report([achievment]) { error
                    in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    print("GC achievement added")
                }
                print("game won")
                GKLeaderboard.submitScore(1, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["grp.WordleysWon"],  completionHandler: {error in
                    if(error != nil){
                        print("Error uploading score to Game Center leaderboard: \(String(describing: error))")
                    }
                })
            }
            if newStatus == .lost {
                // GC achievement
                // lost at wordley
                let achievment = GKAchievement(identifier: "grp.lostAtWordley")
                achievment.percentComplete = 100
                achievment.showsCompletionBanner = true
                GKNotificationBanner.show(withTitle:"Oh Well",
                                          message:"Bummer, you didn't win this time.",
                                          completionHandler: nil)
                GKAchievement.report([achievment]) { error
                    in
                    guard error == nil else {
                        print(error?.localizedDescription ?? "")
                        return
                    }
                    print("done!")
                }
                print("game lost")
            }
          // 3
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showResults = true
          }
        }
          
      }
      // 1
      .onChange(of: scenePhase) { newPhase in
        // 2
        if newPhase == .active {
          if game.status == .new && !game.gameState.isEmpty {
            game.loadState()
          }
        }
        // 3
        if newPhase == .background || newPhase == .inactive {
          game.saveState()
        }
      }


    .frame(alignment: .top)
    .padding([.bottom], 10)
  }
}

struct ContentViewWordley_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewWordley()
  }
}
