//
//  GameItem.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/26/23.
//

import SwiftUI

struct GameItem: View {
    var namespace: Namespace.ID
    var game: Game = games[0]
    @Binding var show: Bool

    var body: some View {
        VStack  {
            Spacer()
            VStack (alignment: .leading, spacing: 12) {
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
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(game.id)", in: namespace)
            )
            
        }
        .foregroundStyle(.white)
        .background(
            Image(game.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
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
        .frame(height: 300)
    }
}

struct GameItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        GameItem(namespace: namespace, show: .constant(true))
    }
}
