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
                ForEach(scores) { s in
                    HStack {
                        Text(s.name)
                        Spacer()
                        Text(s.score)
                    }
                }
            }
        }
    }
}







