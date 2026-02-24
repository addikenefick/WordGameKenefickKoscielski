//
//  ContentView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/19/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Word Game")
                .font(.largeTitle)
                .bold()
                .fontDesign(.serif)
                .foregroundColor(.black)
            
            Button("PLAY") {
            }
            .bold()
            .frame(width: 80, height: 40)
            .background(.black)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            Spacer()
    
        }
        
        
        .padding()
    }
}
