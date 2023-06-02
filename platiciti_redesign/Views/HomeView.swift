//
//  GamesView.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//

import SwiftUI
import GameKit

struct HomeView: View {
    @State var hasScrolled = false
    
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @EnvironmentObject var model: Model
    
    var body: some View {
               
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                scrollDetection
                
                featured
                
                Text("More Games".uppercased())
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .accessibilityAddTraits(.isHeader)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !show {
                        cards
                    } else {
                        ForEach(games) { game in
                            Rectangle()
                                .fill(.white)
                                .frame(height:300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x:0, y: 10)
                                .opacity(0.3)
                            .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
                Spacer()
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(title: "Featured Games", hasScrolled: $hasScrolled)
            )
            .background(
                Image("launchScreenBgIpad")
                    .opacity(0.50)
//                    .offset(x: 200, y: 200)
                    .scaleEffect(0.7)
                    .ignoresSafeArea()
            )
            
            if show {
                detail
            }
            
        }
        .statusBar(hidden: !showStatusBar)
        .onChange(of: show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }

        }
        
    }
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
            
        })
    }
    var featured: some View {
        TabView {
            ForEach(featuredGames) { game in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    
                    FeaturedItem(game: game)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                        .blur(radius: abs(minX / 40))
                        .overlay(
                            Image(game.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 180)
                                .offset(x: 50, y: -75)
                                .offset(x: minX/2)
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 330)

    }
    
    var cards: some View {
        ForEach(games) { game in
            GameItem(namespace: namespace, game: game, show: $show)
                .onTapGesture {
                withAnimation(.openCard) {
                    show.toggle()
                    model.showDetail.toggle()
                    showStatusBar = false
                    selectedID = game.id
                }
            }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }
    }
    
    var detail: some View {
        ForEach(games) { game in
            if game.id == selectedID {
                XGameView(namespace: namespace, game: game, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.1)), removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}
