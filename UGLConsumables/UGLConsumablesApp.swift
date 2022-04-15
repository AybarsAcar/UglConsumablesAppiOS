//
//  UGLConsumablesApp.swift
//  UGLConsumables
//
//  Created by Aybars Acar on 22/1/2022.
//

import SwiftUI

@main
struct UGLConsumablesApp: App {
  
  @AppStorage("isLightTheme") private var isLightTheme: Bool = true
  @AppStorage("token") private var token: String = ""
  @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
  
  @StateObject private var appState = MainAppState()
  
  private let networkMonitor = NetworkMonitor.shared
  
  init() {
    networkMonitor.start()
  }
  
  var body: some Scene {
    WindowGroup {
      ZStack(alignment: .bottom) {
//        if !isLoggedIn {
//          LoginRegisterScreen()
//            .transition(.move(edge: .bottom))
//            .preferredColorScheme(isLightTheme ? .light : .dark)
//        } else {
          HomeScreen()
            .transition(.move(edge: .bottom))
            .preferredColorScheme(isLightTheme ? .light : .dark)
//        }
        
        if networkMonitor.connectionStatus == .unsatisfied {
          SnackbarView(isDisplayed: .constant(true), message: "Not connected to internet", type: .error) {}
        }
      }
    }
  }
}
