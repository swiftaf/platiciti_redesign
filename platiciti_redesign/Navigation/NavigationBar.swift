//
//  NavigationBar.swift
//  platiciti_redesign
//
//  Created by Daniel Zimmerman on 5/23/23.
//

import SwiftUI
import GameKit


struct NavigationBar: View {
    var title = ""
    @Binding var hasScrolled: Bool
    @State var showSheet = false
  
    
    var body: some View {
        
        
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            Text(title)
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
                .accessibilityElement()
                .accessibilityAddTraits(.isHeader)
            
            HStack(spacing:20) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.title.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .strokeStyle(cornerRadius: 14)
                }
                .blurredSheet(.init(.ultraThinMaterial), show: $showSheet) {
                    
                } content: {
                    ZStack {
                        Image("coachmarksWhite")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .background(.black).opacity(0.8)
                            .offset(y: 13)
                            .onTapGesture {
                                showSheet.toggle()
                            }
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("I get it, close this!")
                                .padding(10)
                                .font(.body.bold())
                                .foregroundColor(.white)
                        }
                        .background(.blue)
                        .cornerRadius(8)
                        .ignoresSafeArea()
                        .frame(alignment: .bottom)
                        .shadow(color: .white, radius: 10)
                        .offset(y: -20)
                        
                    }
                    
                }

                    Image(systemName: "person.crop.circle")
                        .font(.title.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .strokeStyle(cornerRadius: 14)
                        .accessibilityElement()
                        .accessibilityLabel("Game Center")
                        .accessibilityAddTraits(.isButton)
                
                
                    
            
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? 0 : 0)
        }
        .frame(height: hasScrolled ? 70 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    
    


    
}


struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", hasScrolled: .constant(false))
    }
}
