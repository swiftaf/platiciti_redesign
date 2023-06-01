//
//  GKMatchmakerViewController.swift
//  Plasticiti
//
//  Created by Daniel Zimmerman on 5/14/23.
//

import UIKit
import GameKit

class MatchmakerViewController: UIViewController {
    // ...

    func findMatch() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 4
        
        let matchmakerVC = GKMatchmakerViewController(matchRequest: request)
        matchmakerVC!.matchmakerDelegate = self
        
        present(matchmakerVC! , animated: true, completion: nil)
    }
}

extension MatchmakerViewController: GKMatchmakerViewControllerDelegate {
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        dismiss(animated: true, completion: nil)
        print("Matchmaking failed: \(error.localizedDescription)")
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        dismiss(animated: true, completion: nil)
        print("Match found!")
        // Start your multiplayer game here...
    }
}
