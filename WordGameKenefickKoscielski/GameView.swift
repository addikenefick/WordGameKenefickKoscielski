//
//  GameView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 2/20/26.
//

import SwiftUI

struct GameView: View {
    @State var consonantLetters: [String] = []
    @State var vowelLetters: [String] = []
    @State var word = " "
    @State var vowels = ["A","E","I","O","U"]
    @State var consonants = [
        "B","C","D","F","G","H","J","K","L","M",
        "N","P","Q","R","S","T","V","W","X","Y","Z"]
    @State var points = 0
    @State var wordd = "test"
    
    @State var notReal = false
    
    var body: some View {
        VStack {
            
            Spacer()
            Button("Refresh"){
                generateLetters()
            }
            .foregroundStyle(.cyan)
            Spacer()
            Text("Points: \(points)")
                .font(.title)
            Spacer()
            Text(" \(word) ")
                .font(.largeTitle)
            HStack {
                ForEach(consonantLetters, id: \.self) { letter in
                    Button(letter) {
                        word += letter
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            
            HStack {
                ForEach(vowelLetters, id: \.self) { letter in
                    Button(letter) {
                        word += letter
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            Spacer()
           
                Button("Submit") {
                    print(word)
                }
                .padding(10)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            HStack{
                Button("Delete"){
                    if !word.isEmpty{
                        word.removeLast()
                    }
                }
                .padding(10)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                Button("Clear"){
                    word = ""
                }
                .padding(10)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
        }
        .onAppear() {
            getDictionary()
            generateLetters()

        }
        
        .alert("Not a real word", isPresented: $notReal) {
            
        }
    }
    func generateLetters() {
        let shuffledConsonants = consonants.shuffled()
        consonantLetters = Array(shuffledConsonants.prefix(6))
        
        let shuffledVowels = vowels.shuffled()
        vowelLetters = Array(shuffledVowels.prefix(3))
        
        word = ""
    }
    func getDictionary() {
        
        let session = URLSession.shared
        
        let dictionaryURL = URL(string: "https://dictionaryapi.com/api/v3/references/collegiate/json/\(wordd)?key=587f7e0d-5c50-4769-a331-613f3d481f68")!
        
        let dataTask = session.dataTask(with: dictionaryURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                if let data = data {
                    //print("\(data)")
                    //print(data)
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data) as? [NSDictionary] {
                        //print(jsonObj.count)
                        //print(jsonObj[0])
                        
                        //if let y = jsonObj[0]["date"] as? String {
                            //print(y)
                        //}
                        
                    } else {
                        notReal = true
                        //print("Error: unable to convert json object")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
    }
}

#Preview {
    GameView()
}
