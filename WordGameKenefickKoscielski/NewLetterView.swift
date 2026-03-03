//
//  NewLetterView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 3/2/26.
//

import SwiftUI

struct NewLetterView: View {
    
    @State var changeLetters: [String]
    
    @State var vowels = ["A","E","I","O","U"]
    
    @State var consonants = [
        "B","C","D","F","G","H","J","K","L","M",
        "N","P","Q","R","S","T","V","W","X","Y","Z"]
    
    @State var vor: Int
    
    var body: some View {
        VStack {
            
            Text("Select a Letter to Change")
            
            HStack {
                ForEach(0..<changeLetters.count, id: \.self) { i in
                    Button(changeLetters[i]) {
                        randomizeLetter(num: 1)
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            
        }
    }
    
    func randomizeLetter(num: Int) {
        let ran: Int
        var count = 0
        if vor == 1 {
            ran = Int.random(in: 0..<consonants.count)
        } else {
            ran = Int.random(in: 0..<vowels.count)
            for i in 0..<changeLetters.count {
                if changeLetters[i] != vowels[ran] {
                    count += 1
                    if count == vowels.count {
                        changeLetters[i] = vowels[ran]
                    }
                }
            }
        }
    }
}

#Preview {
    
}
