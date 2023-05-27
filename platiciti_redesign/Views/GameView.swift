//
//  GameView.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/26/23.
//

import SwiftUI

struct GameView: View {
    var namespace: Namespace.ID
    var game: Game = games[0]
    @Binding var show: Bool
    @State var appear = [false, false, false]
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .background(Color("Background"))
            .ignoresSafeArea()
            
            button
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    var cover: some View {
        
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        .background(
            Image(game.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image\(game.id)", in: namespace)
        )
        .background(
            Image(game.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(game.id)", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(game.id)", in: namespace)
        }
        .overlay(
            VStack (alignment: .leading, spacing: 12){
                Text(game.title)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title\(game.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(game.subtitle.uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle\(game.id)", in: namespace)
                Text(game.text)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text\(game.id)", in: namespace)
                Divider()
                    .opacity(appear[0] ? 1 : 0)
                HStack {
                    Image(systemName: "person.crop.circle")
                        .font(.title.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .strokeStyle(cornerRadius: 14)
                    Text("Designed by Dan")
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
                .offset(y: 250)
                .padding(20)
        )
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("")
                .font(.title3).fontWeight(.medium)
            Text("This Game")
                .font(.title).bold()
            Text("Overhead Shoulder Press · Front Delt Raise · Lateral Delt Raise · Bent-Over Reverse Fly · Arnold Press · Upright Row · Circle PressOverhead Shoulder Press · Front Delt Raise · Lateral Delt Raise · Bent-Over Reverse Fly · Arnold Press · Upright Row · Circle Press")
            Text("Overhead Shoulder Press · Front Delt Raise · Lateral Delt Raise · Bent-Over Reverse Fly · Arnold Press · Upright Row · Circle PressOverhead Shoulder Press · Front Delt Raise · Lateral Delt Raise · Bent-Over Reverse Fly · Arnold Press · Upright Row · Circle Press")
            Text("Multiplatform app")
                .font(.title).bold()
            Text("Overhead Shoulder Press · Front Delt Raise · Lateral Delt Raise · Bent-Over Reverse Fly · Arnold Press · Upright Row · Circle Press")
        }
        .padding(20)
    }
    
    var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
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
}

struct GameView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        GameView(namespace: namespace, show: .constant(true))
    }
}
