//
//  GameView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 2/20/26.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack {
            
        }
        .onAppear() {
            getDictionary()
        }
    }
        
    func getDictionary() {
        
        let session = URLSession.shared
        
        let dictionaryURL = URL(string: "https://od-api-sandbox.oxforddictionaries.com/api/v2&apikey=8a8d9850e91f06af0839113f83a62dda")!
        
        let dataTask = session.dataTask(with: dictionaryURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                if let data = data {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data) as? NSDictionary {
                        print(jsonObj)
                    } else {
                        print("Error: unable to convert json object")
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
