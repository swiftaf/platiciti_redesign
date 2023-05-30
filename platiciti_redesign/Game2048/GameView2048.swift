//
//  GameView.swift
//  SwiftUI2048
//
//  Created by Hongyu on 6/5/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import SwiftUI

extension Edge {
    
    static func from(_ from: GameLogic.Direction) -> Self {
        switch from {
        case .down:
            return .top
        case .up:
            return .bottom
        case .left:
            return .trailing
        case .right:
            return .leading
        }
    }
    
}

struct GameView2048 : View {
    
    @State var ignoreGesture = false
    
    @EnvironmentObject var gameLogic: GameLogic
    
    fileprivate struct LayoutTraits {
        let bannerOffset: CGSize
        let showsBanner: Bool
        let containerAlignment: Alignment
    }
    
    fileprivate func layoutTraits(`for` proxy: GeometryProxy) -> LayoutTraits {
#if os(macOS)
        let landscape = false
#else
        let landscape = proxy.size.width > proxy.size.height
#endif
        
        return LayoutTraits(
            bannerOffset: landscape
                ? .init(width: 32, height: 0)
                : .init(width: 0, height: 32),
            showsBanner: landscape ? proxy.size.width > 720 : proxy.size.height > 550,
            containerAlignment: landscape ? .leading : .top
        )
    }
    
    var gestureEnabled: Bool {
        // Existed for future usage.
#if os(macOS) || targetEnvironment(macCatalyst)
        return false
#else
        return true
#endif
    }
    
    var gesture: some Gesture {
        let threshold: CGFloat = 44
        let drag = DragGesture()
            .onChanged { v in
                guard !self.ignoreGesture else { return }
                
                guard abs(v.translation.width) > threshold ||
                    abs(v.translation.height) > threshold else {
                    return
                }
                
                withTransaction(Transaction(animation: .spring())) {
                    self.ignoreGesture = true
                    
                    if v.translation.width > threshold {
                        // Move right
                        gameLogic.move(.right)
                    } else if v.translation.width < -threshold {
                        // Move left
                        gameLogic.move(.left)
                    } else if v.translation.height > threshold {
                        // Move down
                        gameLogic.move(.down)
                    } else if v.translation.height < -threshold {
                        // Move up
                        gameLogic.move(.up)
                    }
                }
            }
            .onEnded { _ in
                self.ignoreGesture = false
            }
        return drag
    }
    
    var content: some View {
        GeometryReader { proxy in
            bind(self.layoutTraits(for: proxy)) { layoutTraits in
                VStack {
                    
                    ZStack(alignment: layoutTraits.containerAlignment) {
//                        if layoutTraits.showsBanner {
//                            Text("")
//                                .font(Font.system(size: 48).weight(.black))
//                                .foregroundColor(.white)
//                                .offset(layoutTraits.bannerOffset)
//                        }
                        
                        ZStack(alignment: .center) {
                            BlockGridView(matrix:  gameLogic.blockMatrix,
                                          blockEnterEdge: .from(gameLogic.lastGestureDirection))
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .top)
//
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    
                    Spacer()
                    Button {
                        gameLogic.newGame()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(20)
                    .ignoresSafeArea()
                    Spacer()
                }
                .padding(.vertical, 40)
                .background(
                    Color("Background")
//                    Rectangle()
//                        .fill(.blue.gradient)
//                        .edgesIgnoringSafeArea(.all)
                )
            }
        }
    }
    
     
    var body: AnyView {
        return gestureEnabled ? (
            content
                .gesture(gesture, including: .all)>*
            
        ) : content>*
    }
    
}

#if DEBUG
struct GameView2048_Previews : PreviewProvider {
    
    static var previews: some View {
        GameView2048()
            .environmentObject(GameLogic())
    }
    
}
#endif
