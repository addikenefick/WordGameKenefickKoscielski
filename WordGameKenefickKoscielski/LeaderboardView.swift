//
//  SwiftUIView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/23/26.
//
import SwiftData
import SwiftUI
struct LeaderboardView: View {
    
    @State var scores: [Player]
    
    var body: some View {
        VStack{
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
                .fontDesign(.serif)
            
            List {
                ForEach(0..<scores.count, id: \.self) { s in
                    if s < 100 {
                        HStack {
                            Text("\(s + 1). \(scores[s].name)")
                            Spacer()
                            Text("\(scores[s].score)")
                        }
                    }
                }
            }
        }
    }
}







