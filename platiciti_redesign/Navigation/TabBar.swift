//
//  TabBar.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/22/23.
//

import SwiftUI
import GameKit
import GameCenterKit

struct TabBar: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .games
    @State var color: Color = .indigo
    @State var tabItemWidth: CGFloat = 0
//    @State var isGameCenterOpen: Bool = false
    
    
    var body: some View {
        GeometryReader { proxy in
            let hasHomeIndicator = proxy.safeAreaInsets.bottom > 20
            
            HStack {
                buttons
            }
            .padding(.horizontal, 12)
            .padding(.top, 14)
            .frame(height: hasHomeIndicator ? 88 : 62, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: hasHomeIndicator ? 25 : 0, style: .continuous))
            .background(
                background
            )
            .overlay(
                overlay
            )
            .strokeStyle(cornerRadius: hasHomeIndicator ? 25 : 0)
            .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        }

    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                
//                if item.tab == .gameCent {
//                    isGameCenterOpen = true
//                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
//                        selectedTab = item.tab
//                        color = item.color
//                    }
//
//                } else {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        selectedTab = item.tab
                        color = item.color
                    }
//                }
                
                
            } label: {
                VStack(spacing: 0) {
                    Image(systemName: item.icon)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                        .frame(width: 60, height: 29)
                    Text(item.text)
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
            .blendMode(selectedTab == item.tab ? .overlay : .normal)
            .overlay(
                GeometryReader { proxy in
                    //                                Text("\(proxy.size.width)")
                    //
                    Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                    
                }
            )
            .onPreferenceChange(TabPreferenceKey.self) {
                value in
                tabItemWidth = value
            }
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .gameCent { Spacer() }
            if selectedTab == .calHist { Spacer() }
            if selectedTab == .shareRes {
                Spacer()
                Spacer()
            }
            Circle().fill(color).frame(width:tabItemWidth)
            if selectedTab == .games { Spacer() }
            if selectedTab == .calHist {
                Spacer()
                Spacer()
            }
            if selectedTab == .shareRes { Spacer() }
        }
        .padding(.horizontal, 12)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .gameCent { Spacer() }
            if selectedTab == .calHist { Spacer() }
            if selectedTab == .shareRes {
                Spacer()
                Spacer()
            }
            Rectangle()
                .fill(color)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .games { Spacer() }
            if selectedTab == .calHist {
                Spacer()
                Spacer()
            }
            if selectedTab == .shareRes { Spacer() }
        }
        .padding(.horizontal, 12)
    }
    

    
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
//            .preferredColorScheme(.light)
//            .environment(\.sizeCategory, .medium)
//            .previewDevice("iPhone 11")
///            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
