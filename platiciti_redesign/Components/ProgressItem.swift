//
//  ProgressItem.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/26/23.
//

import SwiftUI

struct ProgressItem: View {
    var namespace: Namespace.ID
    var item: Item = items[0]
    @Binding var show: Bool

    var body: some View {
        VStack  {
            VStack (alignment: .leading, spacing: 12) {
                Text(item.title)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title\(item.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.subtitle.uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle\(item.id)", in: namespace)
                Text(item.text)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text\(item.id)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(item.id)", in: namespace)
            )
            
        }
        .foregroundStyle(.white)
        .background(
            Color("AccentColor")
                .opacity(0.3)
            
        )
        .background(
            
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(item.id)", in: namespace)
        }
        .frame(height: 650)
    }
}

struct ProgressItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        ProgressItem(namespace: namespace, show: .constant(true))
    }
}
