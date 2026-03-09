//
//  GameView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 2/20/26.
//

import SwiftUI
import FirebaseDatabaseInternal

struct GameView: View {
    @Binding var thisPlayer: [Player]
    @Binding var personalHighScore: Int
    @State var thisPoints = ""
    @State var newScore = false
    @State var addedName = ""
    @State var consonantLetters: [String] = []
    
    @State var vowelLetters: [String] = []
    
    @State var word = " "
    
    @State var vowels = ["A","E","I","O","U"]
    
    @State var consonants = [
        "B","C","D","F","G","H","J","K","L","M",
        "N","P","Q","R","S","T","V","W","X","Y","Z"]
    
    @State var points = 0
    @State var notReal = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State var over30 = true
    
    @State var over50 = true
    
    @State var wordsPlayed: [String] = []
    
    @State var alreadyPlayed = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Button("End Game") {
                    if points > personalHighScore {
                        personalHighScore = points
                        newScore = true
                    }
                    
                    thisPoints = "\(points)"
                    points = 0
                    
                    dismiss()
                }
                .padding(10)
                .frame(alignment: .leading)
                .background(.red)
                .foregroundStyle(.white)
                .cornerRadius(10)
                
                Spacer()
                
                HStack {
                    NavigationLink("Get new \nConsonant (30 Points)", destination: NewLetterView(changeLetters: $consonantLetters, points: $points, vor: 1))
                    .padding(10)
                    .background(.black)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .navigationBarBackButtonHidden(true)
                    .disabled(over30)
                    
                    NavigationLink("Get new \nVowel (50 Points)", destination: NewLetterView(changeLetters: $vowelLetters, points: $points, vor: 2))
                    .padding(10)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .navigationBarBackButtonHidden(true)
                    .disabled(over50)
                }
                
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
                    getDictionary(theWord: word)
                    word = ""
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
            .alert("New Highscore!", isPresented: $newScore) {
                TextField("What is your name?", text: $addedName)
                Button("Add") {
                    let newPlayer = Player(name: addedName, score: thisPoints)
                    thisPlayer.append(newPlayer)
                    
                    let ref = Database.database().reference()
                    ref.child("leaderboard").childByAutoId().setValue([
                        "name": addedName,
                        "score": thisPoints
                    ])
                }
            }
            
            .onAppear() {
                if vowelLetters.isEmpty && consonantLetters.isEmpty {
                    generateLetters()
                }
                over()
            }
            
            .alert("Not a real word", isPresented: $notReal) {
                
            }
            
            .alert("Already played this word", isPresented: $alreadyPlayed) {
                
            }
        }
    }
    
    func generateLetters() {
        let shuffledConsonants = consonants.shuffled()
        consonantLetters = Array(shuffledConsonants.prefix(6))
        
        let shuffledVowels = vowels.shuffled()
        vowelLetters = Array(shuffledVowels.prefix(3))
        
        word = ""
    }
    
    func over() {
        if points >= 30 {
            over30 = false
            if points >= 50 {
                over50 = false
            }
            else {
                over50 = true
            }
        } else {
            over30 = true
            over50 = true
        }
    }
    
    func getDictionary(theWord: String) {
        
        let session = URLSession.shared
        
        let dictionaryURL = URL(string: "https://dictionaryapi.com/api/v3/references/collegiate/json/\(theWord)?key=587f7e0d-5c50-4769-a331-613f3d481f68")!
        
        let dataTask = session.dataTask(with: dictionaryURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                if let data = data {
                    //print("\(data)")
                    //print(data)
                    if (try? JSONSerialization.jsonObject(with: data) as? [NSDictionary]) != nil {
                        //print(jsonObj.count)
                        //print(jsonObj[0])
                        
                        if wordsPlayed.contains(theWord) {
                            alreadyPlayed = true
                        } else {
                            points += theWord.count
                            
                            if points >= 30 {
                                over30 = false
                                if points >= 50 {
                                    over50 = false
                                } else {
                                    over50 = true
                                }
                            } else {
                                over30 = true
                                over50 = true
                            }
                            
                            wordsPlayed.append(theWord)
                        }
                        
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

