//
//  PlayView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 4/21/26.
//

import SwiftUI

struct PlayView: View {
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
                Button("Easy"){}
                
                    
                    .frame(maxWidth: 150, maxHeight: 70)
                    .background(.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title)
                    .padding(10)
                    
                Button("Medium"){}
                    .padding()
                    .frame(maxWidth: 150, maxHeight: 70)
                    .background(.yellow)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 3)
                    .font(.title2)
                    .padding(10)


                Button("Hard"){}
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

#Preview {
    PlayView()
}
