//
//  GamesView.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//

import SwiftUI
import GameKit

struct AboutView: View {
    @State var hasScrolled = false
    
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @EnvironmentObject var model: Model

    enum Timeframe: String, CaseIterable, Identifiable {
        case week, month, year
        var id: Self { self }
    }
    
    @State private var selectedTimeframe: Timeframe = .week
    
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                VStack {
                    
                    
                    scrollDetection
                    
                    Text("About this app")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 20)
                        .opacity(0.7)
                
                    Text("You think you can do better?")
                        .font(.title2).bold()
                        .opacity(0.7)
                        .padding(.bottom, 40)
                    
                    Text("So do we!".uppercased())
                        .font(.largeTitle).bold()
                        .scaleEffect(1.75)
                        .foregroundColor(Color("Background"))
                        .opacity(1)
                        .background(
                            Rectangle()
                                .frame(width: 370, height: 100)
                                .scaleEffect(2)
                                .opacity(0.9)
                                .cornerRadius(50)
                                .strokeStyle(cornerRadius: 50)
                        )
                        .padding(.bottom, 10)
                        
                        
                    
                    Text("We have a simple mission to empower everyone in the world to be better than they were yesterday.")
                        .multilineTextAlignment(.center)
                        .font(.title3).bold()
                        .opacity(0.7)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 40)
                    Text("You can do it,")
                        .multilineTextAlignment(.center)
                        .font(.title3).bold()
                        .opacity(0.7)
                        .padding(.horizontal, 40)
                    Text("and we hope we can help.")
                        .multilineTextAlignment(.center)
                        .font(.title3).bold()
                        .opacity(0.7)
                        .padding(.horizontal, 40)
                        .padding(.bottom)
                    Text("This app will always be free.")
                        .multilineTextAlignment(.center)
                        .font(.title3).bold()
                        .opacity(0.7)
                        .padding(.horizontal, 40)
                        .padding(.bottom)
                    HStack {
                        Text("Made with")
                            .font(.title3).bold()
                            .opacity(0.7)
                            .padding(.horizontal, 10)
                            .padding(.bottom)
                        
                        Image("largeRainbow")
                            .resizable()
                            .frame(width: 75, height: 70)
                            .shadow(color: Color(.systemBackground), radius: 20)
                        
                        Text("in Florida")
                            .font(.title3).bold()
                            .opacity(0.7)
                            .padding(.horizontal, 10)
                            .padding(.bottom)
                    }
                }
                .coordinateSpace(name: "scroll")
                .safeAreaInset(edge: .top, content: {
                    Color.clear.frame(height: 70)
                })
                .overlay(
                    NavigationBar(title: "Plasticiti", hasScrolled: $hasScrolled)
                )
                .background(
                    Image("launchScreenBgIpad")
                        .opacity(0.40)
                    //                    .offset(x: 200, y: 200)
                        .scaleEffect(1.5)
                        .ignoresSafeArea()
                )
                
                
            }
            Spacer()
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
    

    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
