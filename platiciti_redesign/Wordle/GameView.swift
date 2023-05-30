//
//  GameView.swift
//  Wordle
//
//  Created by Erik Olsson on 2022-01-20.
//

import SwiftUI
import ComposableArchitecture

struct GameView: View {
  let store: Store<AppState, AppAction>

  var body: some View {

    NavigationView {
      ZStack {
          Color("Background")
          .edgesIgnoringSafeArea(.all)

        WithViewStore(store) { viewStore in
          VStack {
            BoardView(store: self.store)
              .layoutPriority(1)
            switch viewStore.gameState {
            case .playing:
              KeyboardView(store: self.store)

            case .gameOver:
              GameOverView(store: self.store)
            }
              Spacer()
          }
//          .toolbar {
//            ToolbarItem(placement: .primaryAction) {
//              Menu {
//                Picker("Language",
//                       selection: viewStore.binding(get: { $0.gameLanguage },
//                                                    send: AppAction.switchLanguage)) {
//                  ForEach(GameLanguage.allCases, id:\.self) { language in
//                    Label(language.description, systemImage: "character.bubble")
//                  }
//                }
//              } label: {
//                Image(systemName: "globe")
//
//              }
//            }
//          }
          .foregroundColor(.gray)

        }
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}


struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(store: Store(initialState: AppState(),
                          reducer: appReducer,
                          environment: AppEnv()))
  }
}

struct BoardView: View {

  private struct BoxView: View {
    let box: LetterBox

    var body: some View {
      Group {
        switch box {
        case .character(let character, let color):
          color.backgroundColor
            .overlay(
              Text(String(character).uppercased())
                .font(.system(.largeTitle).bold())
                .minimumScaleFactor(0.5)
                .foregroundColor(Color("Letters"))
            )
        case .empty:
            Color("Background").opacity(0)
        }
      }
      .animation(.linear, value: box)
      .aspectRatio(1, contentMode: .fit)
      .frame(maxWidth: .infinity)
//      .cornerRadius(8)
      .border(Color("WordleBorder").opacity(0.5), width: 2)
      .padding(0)
    }
  }

  let store: Store<AppState, AppAction>
  @ObservedObject var viewStore: ViewStore<AppState, AppAction>
  init(store: Store<AppState, AppAction>) {
    self.store = store
    self.viewStore = ViewStore(store)
  }

  var body: some View {
    let boxes = viewStore.boxes
    VStack {
      ForEach(0..<boxes.count) { row in
        HStack {
          ForEach(0..<boxes[row].count) { col in
            BoxView(box: boxes[row][col])
          }
        }
      }
    }
    .padding(.horizontal, 40)
  }
}
