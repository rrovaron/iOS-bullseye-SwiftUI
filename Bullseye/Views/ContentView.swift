//
//  ContentView.swift
//  Bullseye
//
//  Created by Rodrigo Rovaron on 29/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State var game: Game
    
    var body: some View {
        ZStack {
            BackgroundView(game: $game)
            VStack {
                InstructionsText(game: $game)
                    .padding(.bottom, alertIsVisible ? 0 : 100)
                if alertIsVisible {
                    PointsView(game: $game,
                               alertIsVisible: $alertIsVisible,
                               sliderValue: $sliderValue)
                    .transition(.scale)
                } else {
                    HitMeButton(game: $game,
                                alertIsVisible: $alertIsVisible,
                                sliderValue: $sliderValue)
                }
            }
            if !alertIsVisible {
                SliderView(game: $game, sliderValue: $sliderValue)
                    .transition(.scale)
            }
        }
    }
}

struct InstructionsText: View {
    
    @Binding var game: Game
    
    var body: some View {
        VStack {
            InstructionText(text: "🎯🎯🎯\nPut the bullseye as close as you can to")
                .padding(.leading, 30.0)
                .padding(.trailing, 30.0)
            BigNumberText(text: String(game.target))
        }
    }
}

struct SliderView: View {
    
    @Binding var game: Game
    @Binding var sliderValue: Double
    
    var body: some View {
        HStack {
            SliderLabelText(text: "1")
            Slider(value: $sliderValue, in: 1.0...100.0)
            SliderLabelText(text: "100")
        }
        .padding()
    }
}

struct HitMeButton: View {
    
    @Binding var game: Game
    @Binding var alertIsVisible: Bool
    @Binding var sliderValue: Double
    
    var body: some View {
        Button(action: {
            withAnimation {
                alertIsVisible = true
            }
        }) {
            Text("Hit met".uppercased())
                .bold()
                .font(.title3)
        }
        .padding(20.0)
        .background(
            ZStack {
                Color("ButtonColor")
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3),
                                                  Color.clear]),
                               startPoint: .top,
                               endPoint: .bottom)
            }
        )
        .foregroundColor(Color.white)
        .cornerRadius(Constants.General.roundRectCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
                .strokeBorder(Color.white, lineWidth: Constants.General.strokeWidth)
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(game: Game())
        ContentView(game: Game()).previewLayout(.fixed(width: 568, height: 320))
        
        ContentView(game: Game()).preferredColorScheme(.dark)
        ContentView(game: Game()).previewLayout(.fixed(width: 568, height: 320)).preferredColorScheme(.dark)
    }
}
