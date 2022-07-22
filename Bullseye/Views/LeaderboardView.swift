//
//  LeaderboardView.swift
//  Bullseye
//
//  Created by Rodrigo Rovaron on 16/07/22.
//

import SwiftUI

struct LeaderboardView: View {
    
    @Binding var leaderboardIsShowing: Bool
    @Binding var game: Game
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10) {
                HeaderView(leaderboardIsShowing: $leaderboardIsShowing)
                LabelView()
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(game.leaderboadEntries.indices, id: \.self) { index in
                            let leaderboardEntry = game.leaderboadEntries[index]
                            RowView(index: index,
                                    score: leaderboardEntry.score,
                                    date: leaderboardEntry.date)
                        }
                    }.padding()
                }
            }
        }
    }
}

struct RowView: View {
    
    let index: Int
    let score: Int
    let date: Date
    
    var body: some View {
        
        HStack {
            RoundedTextView(text: String(index))
            Spacer()
            ScoreText(score: score)
                .frame(width: Constants.Leaderboad.leaderboardScoreColWidth)
            Spacer()
            DateText(date: date)
                .frame(width: Constants.Leaderboad.leaderboardDateColWidth)
        }
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .strokeBorder(Color("LeaderboardRowColor"), lineWidth: Constants.General.strokeWidth)
        )
        .padding(.leading)
        .padding(.trailing)
        .frame(maxWidth: Constants.Leaderboad.leaderboardMaxRowWidth)
    }
}

struct HeaderView: View {
    
    @Binding var leaderboardIsShowing: Bool
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            HStack {
                if verticalSizeClass == .regular &&
                    horizontalSizeClass == .compact {
                    BigBoldText(text: "Leaderboard")
                        .padding(.leading)
                    Spacer()
                } else {
                    BigBoldText(text: "Leaderboard")
                }
            }
            .padding()
            HStack {
                Spacer()
                Button(action: {
                    leaderboardIsShowing = false
                }) {
                    RoundedImageViewFilled(systemName: "xmark")
                        .padding(.trailing)
                }
                
            }
        }.padding()
    }
}

struct LabelView: View {
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: Constants.General.roundedViewLenght)
            Spacer()
            LabelText(text: "Score")
                .frame(width: Constants.Leaderboad.leaderboardScoreColWidth)
            Spacer()
            LabelText(text: "Date")
                .frame(width: Constants.Leaderboad.leaderboardDateColWidth)
        }
        .padding(.leading)
        .padding(.trailing)
        .frame(width: Constants.Leaderboad.leaderboardMaxRowWidth)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    
    static private var leaderboardIsShowing = Binding.constant(false)
    static private var game = Binding.constant(Game(loadTestData: true))
    
    static var previews: some View {
        LeaderboardView(leaderboardIsShowing: leaderboardIsShowing, game: game)
        LeaderboardView(leaderboardIsShowing: leaderboardIsShowing, game: game).previewLayout(.fixed(width: 568, height: 320))
        
        LeaderboardView(leaderboardIsShowing: leaderboardIsShowing, game: game).preferredColorScheme(.dark)
        LeaderboardView(leaderboardIsShowing: leaderboardIsShowing, game: game).previewLayout(.fixed(width: 568, height: 320)).preferredColorScheme(.dark)
    }
}
