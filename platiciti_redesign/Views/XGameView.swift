//
//  GameView.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/26/23.
//

import SwiftUI
import ComposableArchitecture
import GameKit

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct XGameView: View {
    var namespace: Namespace.ID
    var game: Game = games[0]
    @Binding var show: Bool
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero
    @State var isDraggable = true
    let gameLogic = GameLogic()
    var localPlayer = GKLocalPlayer.local
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                Spacer()
            }
            
            .background(Color("Background"))
            
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            .scaleEffect(viewState.width / -500 + 1)
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            
            game.gameView
                .frame(height: 650, alignment: .bottom)
                .matchedGeometryEffect(id: "gameView\(game.id)", in: namespace)
                .offset(y: 145)
                .opacity(appear[2] ? 1 : 0)
                .environmentObject(gameLogic)
            button
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }
    
//    var gameViewView: some View {
//        VStack {
//            Spacer()
//            game.gameView
//        }
//        .background(Color("Background"))
//        .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
//        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
//        .scaleEffect(viewState.width / -500 + 1)
//        .background(.black.opacity(viewState.width / 500))
//        .background(.ultraThinMaterial)
//        .gesture(isDraggable ? drag : nil)
//        .ignoresSafeArea()
//    }
    
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .global).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 150 + scrollY : 150)
            .foregroundStyle(Color("Border"))
            .background(
                Image(game.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .frame(maxWidth: 500)
                    .matchedGeometryEffect(id: "image\(game.id)", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
            )
            .background(
                Image(game.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(game.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY / 10)
            )
            .mask {
                RoundedRectangle(cornerRadius: appear[0] ? 30 : 0, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(game.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            }
            .overlay(
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)
            )
            
                
        }
        .frame(height: 350)
    }
    
    var button: some View {
        Button {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.5)){
                appear[2] = false
            }
            withAnimation(.closeCard) {
                show.toggle()
                model.showDetail.toggle()
                
            }
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
    }
    
    var overlayContent: some View {
        
        VStack (alignment: .leading, spacing: 12){
            Text(game.title)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(game.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            
//            Text(game.subtitle.uppercased())
//                .font(.footnote.weight(.semibold))
//                .matchedGeometryEffect(id: "subtitle\(game.id)", in: namespace)
//            Text(game.text)
//                .font(.footnote)
//                .matchedGeometryEffect(id: "text\(game.id)", in: namespace)
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack {
                Image(systemName: "calendar")
                    .font(.title.weight(.bold))
                    .frame(width: 30, height: 30)
                    .foregroundColor(.secondary)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .strokeStyle(cornerRadius: 14)
                Text(game.tagLine)
                    .font(.footnote)
            }
            .opacity(appear[1] ? 1 : 0)
            
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .matchedGeometryEffect(id: "blur\(game.id)", in: namespace)
            )
            .offset(y: 90)
            .padding(20)
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard) {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
                
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.closeCard) {
                        viewState = .zero
                    }
                }
            }
    }
    
    func fadeIn() {
        
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.6)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        
        appear[0] = false
        appear[1] = false
    }
    
    func close () {
        withAnimation(.closeCard.delay(0.3)) {
            show.toggle()
            model.showDetail.toggle()
        }
        withAnimation(.closeCard) {
            viewState = .zero
        }
        
        isDraggable = false
    }
}

struct XGameView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        XGameView(namespace: namespace, show: .constant(true))
            .environmentObject(Model())
    }
}
