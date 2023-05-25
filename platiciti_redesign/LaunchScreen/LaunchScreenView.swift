//
//  LaunchScreenView.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager // Mark 1

    @State private var firstAnimation = false  // Mark 2
    @State private var secondAnimation = false // Mark 2
    @State private var startFadeoutAnimation = false // Mark 2
    
    @ViewBuilder
    private var image: some View {  // Mark 3
        Image("whiteHeart")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .scaleEffect(firstAnimation ? 1 : 1.2) // Mark 4
            .scaleEffect(secondAnimation ? 0 : 1) // Mark 4
            .offset(y: secondAnimation ? 400 : 0) // Mark 4
    }
    
    @ViewBuilder
    private var logoText: some View {  // Mark 3
        Image("whiteLogoText")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 100)
            .offset(y: -15)
    }

    @ViewBuilder
    private var madeInFl: some View {  // Mark 3
        Image("madeInFl")
            .resizable()
            .scaledToFit()
            .frame(width: 225)
    }
    
    @ViewBuilder
    private var backgroundColor: some View {  // Mark 3
        Color.blue.ignoresSafeArea().opacity(0.5)
    }
    
    @ViewBuilder
    private var backgroundImage: some View {  // Mark 3
        Image("launchScreenBgIpad")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
        
    }
    
    
    private let animationTimer = Timer // Mark 5
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()
    
    var body: some View {
            ZStack {
                backgroundColor  // Mark 3
                backgroundImage
                VStack {
                    Spacer()
                    image  // Mark 3
                    logoText
                    Spacer()
                    madeInFl
                    
                }
                
            }.onReceive(animationTimer) { timerValue in
                updateAnimation()  // Mark 5
            }.opacity(startFadeoutAnimation ? 0 : 1)
        
    }
    
    private func updateAnimation() { // Mark 5
        switch launchScreenState.state {
        case .firstStep:
            withAnimation(.easeInOut(duration: 0.9)) {
                firstAnimation.toggle()
            }
        case .secondStep:
            if secondAnimation == false {
                withAnimation(.linear) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                }
            }
        case .finished:
            // use this case to finish any work needed
            break
        }
    }
    
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
