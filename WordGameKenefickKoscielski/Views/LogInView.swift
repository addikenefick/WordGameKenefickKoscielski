//
//  LogInView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 4/21/26.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LogInView: View {
    var body: some View {
        VStack {
            Text("Word Game")
            
            GoogleSignInButton(action: handleSignInButton)
        }
        .onAppear {
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                // Check if `user` exists; otherwise, do something with `error`
                if user != nil {
                    //print(user!)
                } else {
                    //print(error!)
                }
            }
        }
    }
    
    func handleSignInButton() {
        let rootVC = getRootViewController()
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { signInResult, error in
            guard signInResult != nil else {
                print(error!)
                return
            }
            
        }
    }
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
    
}

#Preview {
    LogInView()
}
