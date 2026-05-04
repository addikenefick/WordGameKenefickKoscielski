//
//  PlayView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 4/21/26.
//

import SwiftUI

struct PlayView: View {
    
    @Binding var players: [Player]
    
    @Binding var easyHigh: Int
    @Binding var mediumHigh: Int
    @Binding var hardHigh: Int
    var body: some View {
        NavigationStack{
            VStack{
                Text("Play")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.serif)
                    .padding(.top, 20)
                Text("Select game mode")
                    .fontDesign(.serif)
                    .font(.headline)
                Spacer()
                NavigationLink("Easy"){
                    GameView(
                        thisPlayer: $players,
                        easyHigh: $easyHigh,
                        mediumHigh: $mediumHigh,
                        hardHigh: $hardHigh,
                        gamemode: 1
                    )
                }
                
                    
                    .frame(maxWidth: 150, maxHeight: 70)
                    .background(.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title)
                    .padding(10)
                    
                NavigationLink("Medium"){
                    GameView(
                        thisPlayer: $players,
                        easyHigh: $easyHigh,
                        mediumHigh: $mediumHigh,
                        hardHigh: $hardHigh,
                        gamemode: 2
                    )
                }
                    .padding()
                    .frame(maxWidth: 150, maxHeight: 70)
                    .background(.yellow)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title2)
                    .padding(10)


                NavigationLink("Hard"){
                    GameView(
                        thisPlayer: $players,
                        easyHigh: $easyHigh,
                        mediumHigh: $mediumHigh,
                        hardHigh: $hardHigh,
                        gamemode: 3
                    )
                }
                    .padding()
                    .frame(maxWidth: 150, maxHeight: 70)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title)
                    .padding(10)


Spacer()

            }
        }
    }
        
}


