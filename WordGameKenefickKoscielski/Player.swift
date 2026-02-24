//
//  Highscore.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/23/26.
//

import SwiftData
import Foundation
class Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}
