//
//  SettingsView.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 4/21/26.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            VStack{
              Text("settings")
                NavigationLink("login"){
                    LogInView()
                    }
                }
            }
        }
    }


#Preview {
    SettingsView()
}
