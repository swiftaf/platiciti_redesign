////
////  GameCenterHelper.swift
////  Plasticiti
////
////  Created by Daniel Zimmerman on 12/5/22.
////
//import SwiftUI
//import GameKit
//
//
//class GameCenterHelper: NSObject, GKLocalPlayerListener {
//    
//    // initialize leaderboardID
//    private let leaderboardID = ""
//    
//    // message for notifications
//    let inviteMessage:String = ""
//    var currentVC: GKMatchmakerViewController?
//    
//    var viewController: UIViewController?
//    
//    // initialize self
//    init(vc:HomeView) {
//        super.init()
//        self.viewController = vc
//    }
//    
//    // call global authentication
//    func loadGameCenter(){
//        self.authenticate()
//    }
//    
//    // global authentication
//    func authenticate(){
//        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
//            NotificationCenter.default.post(name: Notification.Name.authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)
//            
//            // if auth
//            if GKLocalPlayer.local.isAuthenticated {
//                // set up GC
//                GKLocalPlayer.local.register(self)
//                self.viewController?.viewDidAppear(true)
//                
//                // set up GC access point
//                //GKAccessPoint.shared.parentWindow = self.viewController?.view.window
//                GKAccessPoint.shared.location = .topLeading
//                GKAccessPoint.shared.showHighlights = true
//                GKAccessPoint.shared.isActive = GKLocalPlayer.local.isAuthenticated
//                
//            // if on auth VC
//            } else if let vc = gcAuthVC {
//                self.viewController?.present(vc, animated: true, completion: {
//                      //
//                    })
//            // auth failed
//            } else {
//                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
//            }
//        }
//    }
//
//    // username
//    var playerName = GKLocalPlayer.local.alias
//    
//    // display GC dashboard
//    func showDashboard(){
//        let viewController = GKGameCenterViewController(state: .dashboard)
//        viewController.gameCenterDelegate = self
//            self.viewController?.present(viewController, animated: true, completion: {
//            })
//
//    }
//    
//    // update GC score
//    func updateScore(with value: Int) {
//        GKLeaderboard.submitScore(value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [self.leaderboardID],  completionHandler: {error in
//            if(error != nil){
//                print("Error uploading score to Game Center leaderboard: \(String(describing: error))")
//            }
//        })
//    }
//    
//    // update GC achievements
//    func updateCertificates(with value: Int) {
//        GKLeaderboard.submitScore(value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [self.leaderboardID],  completionHandler: {error in
//            if(error != nil){
//                print("Error uploading score to Game Center leaderboard: \(String(describing: error))")
//            }
//        })
//    }
//    
//}
//
//// GC helper
//extension GameCenterHelper: GKGameCenterControllerDelegate {
//    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
//        gameCenterViewController.dismiss(animated: true)
//    }
//}
//
//// notifications
//extension Notification.Name {
//  static let presentGame = Notification.Name(rawValue: "presentGame")
//  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
//}
