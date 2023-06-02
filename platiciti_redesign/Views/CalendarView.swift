//
//  GamesView.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/21/23.
//

import SwiftUI
import GameKit

struct CalendarView: View {
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
                    
                    Text("This week")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 20)
                        .opacity(0.7)
                    
                    
                    Picker("Timeframe", selection: $selectedTimeframe) {
                        Text("Week").tag(Timeframe.week)
  
                        Text("Month").tag(Timeframe.month)
                        Text("Year").tag(Timeframe.year)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                    
                    Spacer()
                    
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("Color 5"), Color("Color 9")]), startPoint: .leading, endPoint: .trailing)
                        )
                        .opacity(1)
                        .frame(width: 150, height: 150)
                        
                        .overlay {
                            Text("Wordley 30 wins!")
                                .font(.title).bold()
                        }
                        .opacity(0.7)
                        .offset(x:-100)
                        .shadow(color: Color("AccentColor"), radius: 10)
                    
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("Color 3"), Color("Color 8")]), startPoint: .leading, endPoint: .trailing)
                        )
                        .opacity(1)
                        .frame(width: 80, height: 80)
                        
                        .overlay {
                            Text("SlideIt 1024!")
                                .font(.title3).bold()
                                .multilineTextAlignment(.center)
                        }
                        .opacity(0.7)
                        .offset(x:100, y: -85)
                        .shadow(color: Color("AccentColor"), radius: 10)
                    
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("Color 2"), Color("Color 6")]), startPoint: .leading, endPoint: .trailing)
                        )
                        .opacity(1)
                        .frame(width: 120, height: 120)
                        
                        .overlay {
                            Text("Tic-Tac-Toe 21 wins!")
                                .font(.title2).bold()
                                .multilineTextAlignment(.center)
                        }
                        .opacity(0.7)
                        .offset(x: -10, y: -85)
                        .shadow(color: Color("AccentColor"), radius: 10)
                 
                    Spacer()
                    
                    VStack {
                        Text("Progress")
                            .font(.largeTitle).bold()
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.vertical, 10)
                        HStack {
                            Text("Progress last week")
                                .font(.title3)
                            Spacer()
                            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                                .font(.largeTitle)
                        }
                        HStack {
                            Text("Progress last month")
                                .font(.title3)
                            Spacer()
                            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                                .font(.largeTitle)
                        }
                        Spacer()
                    }
                    .offset(y: -100)
                    .padding(.horizontal, 30)
                    .background(
                        Image("launchScreenBgIpad")
                            .resizable()
                            .opacity(0.4)
                            .rotationEffect(.degrees(180))
//                        Rectangle()
//                            .fill(
//                                LinearGradient(colors: [Color("AccentColor"), Color("Background")], startPoint: .top, endPoint: .bottom)
//                            )
 
                            .mask(RoundedRectangle (cornerRadius: 30, style: .continuous))
                                .frame(height: 400)
                        
                                .strokeStyle(cornerRadius: 30)
                    )
                    .offset(y: 70)
                }


            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(title: "Progress", hasScrolled: $hasScrolled)
            )
            .background(
                Image("launchScreenBgIpad")
                    .opacity(0.40)
//                    .offset(x: 200, y: 200)
                    .scaleEffect(0.7)
                    .ignoresSafeArea()
            )
           

        }
        Spacer()
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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
