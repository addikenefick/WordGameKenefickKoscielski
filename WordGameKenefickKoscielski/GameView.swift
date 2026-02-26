//
//  GameView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 2/20/26.
//

import SwiftUI

struct GameView: View {
    
    @State var word = "test"
    
    var body: some View {
        VStack {
            
        }
        .onAppear() {
            getDictionary()
        }
    }
        
    func getDictionary() {
        
        let session = URLSession.shared
        
        let dictionaryURL = URL(string: "https://dictionaryapi.com/api/v3/references/collegiate/json/test?key=587f7e0d-5c50-4769-a331-613f3d481f68")!
        
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
                        print(jsonObj[0])
                        if let y = jsonObj[0]["date"] as? String {
                            //print(y)
                        }
                        
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
