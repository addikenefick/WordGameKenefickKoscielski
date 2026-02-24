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
                .foregroundColor(.black)
            List{
                HStack{
                    ForEach(scores){s in
                        Text("\(s.name)")
                        Text("\(s.score)")
                    }
                }
            }
        }
    }
}

