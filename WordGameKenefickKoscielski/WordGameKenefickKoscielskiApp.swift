
//
//  WordGameKenefickKoscielskiApp.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/19/26.
//
import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

func application(
  _ app: UIApplication,
  open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
) -> Bool {
  var handled: Bool

  handled = GIDSignIn.sharedInstance.handle(url)
  if handled {
    return true
  }

  // Handle other custom URL types.

  // If not handled by this app, return false.
  return false
}

@main
struct WordGameKenefickKoscielski: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
              .preferredColorScheme(.light)
      }
    }
  }
}
