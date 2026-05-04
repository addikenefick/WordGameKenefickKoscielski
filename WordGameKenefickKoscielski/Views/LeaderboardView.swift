//
//  SwiftUIView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/23/26.
//
import SwiftData
import SwiftUI
struct LeaderboardView: View {
    
    @Binding var scores: [Player]
    var selectedMode: Int
    
    var body: some View {
        VStack{
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
                .fontDesign(.serif)
            
            List {
                
                let filtered = scores.filter { $0.mode == selectedMode }
                let sortedScores = filtered.sorted {
                    (Int($0.score)) > (Int($1.score))
                }
                ForEach(0..<sortedScores.count, id: \.self) { s in
                    if s < 100 {
                        HStack {
                            Text("\(s + 1). \(sortedScores[s].name)")
                            Spacer()
                            Text("\(sortedScores[s].score)")
                        }
                    }
                }
            }
        }
    }
}
