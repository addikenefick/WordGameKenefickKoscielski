//
//  SwiftUIView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/23/26.
//
import SwiftData
import SwiftUI
struct LeaderboardView: View {
    var scores: [Player]
    var body: some View {
        VStack{
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
                .fontDesign(.serif)
            
            List {
                ForEach(0..<scores.count, id: \.self) { s in
                    let newScores = scores.sorted(by: { $0.score > $1.score })
                    if s < 100 {
                        HStack {
                            Text("\(s + 1). \(newScores[s].name)")
                            Spacer()
                            Text("\(newScores[s].score)")
                        }
                    }
                }
            }
        }
    }
}







