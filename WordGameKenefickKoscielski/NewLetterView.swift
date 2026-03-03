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
    
    @State var goBack = false
    
    @State var vor: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Select a Letter to Change")
                
                HStack {
                    ForEach(0..<changeLetters.count, id: \.self) { i in
                        Button(changeLetters[i]) {
                            randomizeLetter(num: i)
                        }
                        .frame(width: 50, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                
            }
            
        }
    }
    
    func randomizeLetter(num: Int) {
        var ran: Int
        var count = 0
        if vor == 1 {
            ran = Int.random(in: 0..<consonants.count)
            for var i in 0..<changeLetters.count {
                if changeLetters[i] != consonants[ran] {
                    count += 1
                    if count == consonants.count {
                        changeLetters[num] = consonants[ran]
                    }
                    else {
                        i = 0
                        ran = Int.random(in: 0..<vowels.count)
                        count = 0
                    }
                }
            }
        } else {
            ran = Int.random(in: 0..<vowels.count)
            for var i in 0..<changeLetters.count {
                if changeLetters[i] != vowels[ran] {
                    count += 1
                    if count == vowels.count {
                        changeLetters[num] = vowels[ran]
                    }
                    else {
                        i = 0
                        ran = Int.random(in: 0..<vowels.count)
                        count = 0
                    }
                }
            }
        }
    }
}

#Preview {
    
}
