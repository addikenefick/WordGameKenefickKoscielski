//
//  NewLetterView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 3/2/26.
//

import SwiftUI

struct NewLetterView: View {
    
    @Binding var changeLetters: [String]
    
    @Binding var points: Int
    
    @State var vowels = ["A","E","I","O","U"]
    
    @State var consonants = [
        "B","C","D","F","G","H","J","K","L","M",
        "N","P","Q","R","S","T","V","W","X","Y","Z"]
    
    @State var vor: Int
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Select a Letter to Change")
                
                Spacer()
                
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
                
                Spacer()
                
                Button("Cancel") {
                    dismiss()
                }
                .padding(10)
                .foregroundStyle(.white)
                .background(.red)
                .cornerRadius(10)
                
            }
            
        }
    }
    
    func randomizeLetter(num: Int) {
        var ran: Int
        
        if vor == 1 {
            
            ran = Int.random(in: 0..<consonants.count)
            
            while changeLetters.contains(consonants[ran]) {
                ran = Int.random(in: 0..<consonants.count)
            }
            
            changeLetters[num] = consonants[ran]
            points -= 30
            
        } else {
            
            ran = Int.random(in: 0..<vowels.count)
            
            while changeLetters.contains(vowels[ran]) {
                ran = Int.random(in: 0..<vowels.count)
            }
            
            changeLetters[num] = vowels[ran]
            points -= 50
        }
        
        dismiss()
    }
}

#Preview {
    
}
