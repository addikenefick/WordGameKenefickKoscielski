//
//  PlayView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 4/21/26.
//

import SwiftUI

struct PlayView: View {
    @Binding var thisPlayer: [Player]
    @Binding var personalHighScore: Int
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
                    GameView(thisPlayer: $thisPlayer,
                           personalHighScore: $personalHighScore,
                           numConsonants: 10,
                           numVowels: 5)
                   
                }
                
                    
                    .frame(maxWidth: 130, maxHeight: 50)
                    .background(.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title2)
                    .padding(10)
                    
              
                    NavigationLink("Medium") {
                        GameView(
                            thisPlayer: $thisPlayer,
                            personalHighScore: $personalHighScore,
                            numConsonants: 6,
                            numVowels: 3
                        )
                    }
                
                    .padding()
                    .frame(maxWidth: 130, maxHeight: 50)
                    .background(.yellow)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title2)
                    .padding(10)


                NavigationLink("Hard") {
                    GameView(
                        thisPlayer: $thisPlayer,
                        personalHighScore: $personalHighScore,
                        numConsonants: 5,
                        numVowels: 2
                    )
                }
                    .padding()
                    .frame(maxWidth: 130, maxHeight: 50)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title2)
                    .padding(10)


Spacer()

            }
        }
    }
        
}

//#Preview {
//    PlayView()
//}
